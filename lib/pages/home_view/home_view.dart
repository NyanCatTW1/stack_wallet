/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_config.dart';
import '../../providers/global/notifications_provider.dart';
import '../../providers/global/prefs_provider.dart';
import '../../providers/ui/home_view_index_provider.dart';
import '../../providers/ui/unread_notifications_provider.dart';
import '../../services/event_bus/events/global/tor_connection_status_changed_event.dart';
import '../../themes/stack_colors.dart';
import '../../themes/theme_providers.dart';
import '../../utilities/assets.dart';
import '../../utilities/constants.dart';
import '../../utilities/text_styles.dart';
import '../../widgets/animated_widgets/rotate_icon.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/background.dart';
import '../../widgets/custom_buttons/app_bar_icon_button.dart';
import '../../widgets/small_tor_icon.dart';
import '../../widgets/stack_dialog.dart';
import '../buy_view/buy_view.dart';
import '../exchange_view/exchange_view.dart';
import '../notification_views/notifications_view.dart';
import '../settings_views/global_settings_view/global_settings_view.dart';
import '../settings_views/global_settings_view/hidden_settings.dart';
import '../wallets_view/wallets_view.dart';
import 'sub_widgets/home_view_button_bar.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const routeName = "/home";

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late final PageController _pageController;
  late final RotateIconController _rotateIconController;

  late final List<Widget> _children;

  DateTime? _cachedTime;

  bool _exitEnabled = false;

  late TorConnectionStatus _currentSyncStatus;

  // final _buyDataLoadingService = BuyDataLoadingService();

  Future<bool> _onWillPop() async {
    // go to home view when tapping back on the main exchange view
    if (ref.read(homeViewPageIndexStateProvider.state).state != 0) {
      ref.read(homeViewPageIndexStateProvider.state).state = 0;
      return false;
    }

    if (_exitEnabled) {
      return true;
    }

    final now = DateTime.now();
    const timeout = Duration(milliseconds: 1500);
    if (_cachedTime == null || now.difference(_cachedTime!) > timeout) {
      _cachedTime = now;
      await showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder:
            (_) => WillPopScope(
              onWillPop: () async {
                _exitEnabled = true;
                return true;
              },
              child: const StackDialog(title: "Tap back again to exit"),
            ),
      ).timeout(
        timeout,
        onTimeout: () {
          _exitEnabled = false;
          Navigator.of(context).pop();
        },
      );
    }
    return _exitEnabled;
  }

  // void _loadSimplexData() {
  //   // unawaited future
  //   if (ref.read(prefsChangeNotifierProvider).externalCalls) {
  //     _buyDataLoadingService.loadAll(ref);
  //   } else {
  //     Logging.instance.log("User does not want to use external calls",
  //         level: LogLevel.Info);
  //   }
  // }

  bool _lock = false;

  Future<void> _animateToPage(int index) async {
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  void initState() {
    _pageController = PageController();
    _rotateIconController = RotateIconController();
    _children = [
      const WalletsView(),
      if (AppConfig.hasFeature(AppFeature.swap) && Constants.enableExchange)
        const ExchangeView(),
      if (AppConfig.hasFeature(AppFeature.buy) && Constants.enableExchange)
        const BuyView(),
    ];

    ref.read(notificationsProvider).startCheckingWatchedNotifications();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   showOneTimeTorHasBeenAddedDialogIfRequired(context);
    // });

    super.initState();
  }

  @override
  dispose() {
    _pageController.dispose();
    _rotateIconController.forward = null;
    _rotateIconController.reverse = null;
    _rotateIconController.reset = null;
    super.dispose();
  }

  DateTime _hiddenTime = DateTime.now();
  int _hiddenCount = 0;

  void _hiddenOptions() {
    _rotateIconController.reset?.call();
    _rotateIconController.forward?.call();
    if (_hiddenCount == 5) {
      Navigator.of(context).pushNamed(HiddenSettings.routeName);
    }
    final now = DateTime.now();
    const timeout = Duration(seconds: 1);
    if (now.difference(_hiddenTime) < timeout) {
      _hiddenCount++;
    } else {
      _hiddenCount = 0;
    }
    _hiddenTime = now;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    // dirty hack
    ref.listen(
      prefsChangeNotifierProvider.select((value) => value.enableExchange),
      (prev, next) {
        if (next == false &&
            mounted &&
            ref.read(homeViewPageIndexStateProvider) != 0) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => ref.read(homeViewPageIndexStateProvider.state).state = 0,
          );
        }
      },
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _key,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:
                Theme.of(context).extension<StackColors>()!.backgroundAppBar,
            title: Row(
              children: [
                GestureDetector(
                  onTap: _hiddenOptions,
                  child: RotateIcon(
                    icon: const AppIcon(width: 24, height: 24),
                    curve: Curves.easeInOutCubic,
                    rotationPercent: 1.0,
                    controller: _rotateIconController,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "My ${AppConfig.prefix}",
                  style: STextStyles.navBarTitle(context),
                ),
              ],
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                child: AspectRatio(aspectRatio: 1, child: SmallTorIcon()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppBarIconButton(
                    semanticsLabel:
                        "Notifications Button. Takes To Notifications Page.",
                    key: const Key("walletsViewAlertsButton"),
                    size: 36,
                    shadows: const [],
                    color:
                        Theme.of(
                          context,
                        ).extension<StackColors>()!.backgroundAppBar,
                    icon:
                        ref.watch(
                              notificationsProvider.select(
                                (value) => value.hasUnreadNotifications,
                              ),
                            )
                            ? SvgPicture.file(
                              File(
                                ref.watch(
                                  themeProvider.select(
                                    (value) => value.assets.bellNew,
                                  ),
                                ),
                              ),
                              width: 20,
                              height: 20,
                              color:
                                  ref.watch(
                                        notificationsProvider.select(
                                          (value) =>
                                              value.hasUnreadNotifications,
                                        ),
                                      )
                                      ? null
                                      : Theme.of(context)
                                          .extension<StackColors>()!
                                          .topNavIconPrimary,
                            )
                            : SvgPicture.asset(
                              Assets.svg.bell,
                              width: 20,
                              height: 20,
                              color:
                                  ref.watch(
                                        notificationsProvider.select(
                                          (value) =>
                                              value.hasUnreadNotifications,
                                        ),
                                      )
                                      ? null
                                      : Theme.of(context)
                                          .extension<StackColors>()!
                                          .topNavIconPrimary,
                            ),
                    onPressed: () {
                      // reset unread state
                      ref.refresh(unreadNotificationsStateProvider);

                      Navigator.of(
                        context,
                      ).pushNamed(NotificationsView.routeName).then((_) {
                        final Set<int> unreadNotificationIds =
                            ref
                                .read(unreadNotificationsStateProvider.state)
                                .state;
                        if (unreadNotificationIds.isEmpty) return;

                        final List<Future<void>> futures = [];
                        for (
                          int i = 0;
                          i < unreadNotificationIds.length - 1;
                          i++
                        ) {
                          futures.add(
                            ref
                                .read(notificationsProvider)
                                .markAsRead(
                                  unreadNotificationIds.elementAt(i),
                                  false,
                                ),
                          );
                        }

                        // wait for multiple to update if any
                        Future.wait(futures).then((_) {
                          // only notify listeners once
                          ref
                              .read(notificationsProvider)
                              .markAsRead(unreadNotificationIds.last, true);
                        });
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppBarIconButton(
                    semanticsLabel: "Settings Button. Takes To Settings Page.",
                    key: const Key("walletsViewSettingsButton"),
                    size: 36,
                    shadows: const [],
                    color:
                        Theme.of(
                          context,
                        ).extension<StackColors>()!.backgroundAppBar,
                    icon: SvgPicture.asset(
                      Assets.svg.gear,
                      color:
                          Theme.of(
                            context,
                          ).extension<StackColors>()!.topNavIconPrimary,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      //todo: check if print needed
                      // debugPrint("main view settings tapped");
                      Navigator.of(
                        context,
                      ).pushNamed(GlobalSettingsView.routeName);
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (_children.length > 1 &&
                    ref.watch(prefsChangeNotifierProvider).enableExchange)
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(
                            context,
                          ).extension<StackColors>()!.backgroundAppBar,
                      boxShadow:
                          Theme.of(context)
                                      .extension<StackColors>()!
                                      .homeViewButtonBarBoxShadow !=
                                  null
                              ? [
                                Theme.of(context)
                                    .extension<StackColors>()!
                                    .homeViewButtonBarBoxShadow!,
                              ]
                              : null,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        bottom: 12,
                        right: 16,
                        top: 0,
                      ),
                      child: HomeViewButtonBar(),
                    ),
                  ),
                Expanded(
                  child: Consumer(
                    builder: (_, _ref, __) {
                      _ref.listen(homeViewPageIndexStateProvider, (
                        previous,
                        next,
                      ) {
                        if (next is int && next >= 0 && next <= 2) {
                          // if (next == 1) {
                          //   _exchangeDataLoadingService.loadAll(ref);
                          // }
                          // if (next == 2) {
                          //   _buyDataLoadingService.loadAll(ref);
                          // }

                          _lock = true;
                          _animateToPage(next).then((value) => _lock = false);
                        }
                      });
                      return PageView(
                        controller: _pageController,
                        children: _children,
                        onPageChanged: (pageIndex) {
                          if (!_lock) {
                            ref
                                .read(homeViewPageIndexStateProvider.state)
                                .state = pageIndex;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
