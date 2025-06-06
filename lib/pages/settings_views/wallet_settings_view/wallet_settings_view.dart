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

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../../db/hive/db.dart';
import '../../../db/sqlite/firo_cache.dart';
import '../../../models/epicbox_config_model.dart';
import '../../../models/keys/key_data_interface.dart';
import '../../../models/keys/view_only_wallet_data.dart';
import '../../../notifications/show_flush_bar.dart';
import '../../../providers/global/wallets_provider.dart';
import '../../../providers/ui/transaction_filter_provider.dart';
import '../../../route_generator.dart';
import '../../../services/event_bus/events/global/node_connection_status_changed_event.dart';
import '../../../services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import '../../../services/event_bus/global_event_bus.dart';
import '../../../themes/stack_colors.dart';
import '../../../utilities/assets.dart';
import '../../../utilities/show_loading.dart';
import '../../../utilities/text_styles.dart';
import '../../../utilities/util.dart';
import '../../../wallets/crypto_currency/crypto_currency.dart';
import '../../../wallets/crypto_currency/intermediate/frost_currency.dart';
import '../../../wallets/crypto_currency/intermediate/nano_currency.dart';
import '../../../wallets/wallet/impl/bitcoin_frost_wallet.dart';
import '../../../wallets/wallet/impl/epiccash_wallet.dart';
import '../../../wallets/wallet/intermediate/lib_monero_wallet.dart';
import '../../../wallets/wallet/wallet_mixin_interfaces/extended_keys_interface.dart';
import '../../../wallets/wallet/wallet_mixin_interfaces/mnemonic_interface.dart';
import '../../../wallets/wallet/wallet_mixin_interfaces/view_only_option_interface.dart';
import '../../../widgets/background.dart';
import '../../../widgets/custom_buttons/app_bar_icon_button.dart';
import '../../../widgets/desktop/secondary_button.dart';
import '../../../widgets/rounded_white_container.dart';
import '../../../widgets/stack_dialog.dart';
import '../../address_book_views/address_book_view.dart';
import '../../home_view/home_view.dart';
import '../../pinpad_views/lock_screen_view.dart';
import '../global_settings_view/syncing_preferences_views/syncing_preferences_view.dart';
import '../sub_widgets/settings_list_button.dart';
import 'frost_ms/frost_ms_options_view.dart';
import 'wallet_backup_views/wallet_backup_view.dart';
import 'wallet_network_settings_view/wallet_network_settings_view.dart';
import 'wallet_settings_wallet_settings/change_representative_view.dart';
import 'wallet_settings_wallet_settings/wallet_settings_wallet_settings_view.dart';
import 'wallet_settings_wallet_settings/xpub_view.dart';

/// [eventBus] should only be set during testing
class WalletSettingsView extends ConsumerStatefulWidget {
  const WalletSettingsView({
    super.key,
    required this.walletId,
    required this.coin,
    required this.initialSyncStatus,
    required this.initialNodeStatus,
    this.eventBus,
  });

  static const String routeName = "/walletSettings";

  final String walletId;
  final CryptoCurrency coin;
  final WalletSyncStatus initialSyncStatus;
  final NodeConnectionStatus initialNodeStatus;
  final EventBus? eventBus;

  @override
  ConsumerState<WalletSettingsView> createState() => _WalletSettingsViewState();
}

class _WalletSettingsViewState extends ConsumerState<WalletSettingsView> {
  late final String walletId;
  late final CryptoCurrency coin;
  late String xpub;
  late final bool xPubEnabled;

  late final EventBus eventBus;

  late WalletSyncStatus _currentSyncStatus;
  // late NodeConnectionStatus _currentNodeStatus;

  late StreamSubscription<dynamic> _syncStatusSubscription;
  // late StreamSubscription _nodeStatusSubscription;

  @override
  void initState() {
    walletId = widget.walletId;
    coin = widget.coin;

    final wallet = ref.read(pWallets).getWallet(walletId);
    if (wallet is ViewOnlyOptionInterface && wallet.isViewOnly) {
      xPubEnabled = false;
    } else {
      xPubEnabled = wallet is ExtendedKeysInterface;
    }

    xpub = "";

    _currentSyncStatus = widget.initialSyncStatus;
    // _currentNodeStatus = widget.initialNodeStatus;

    eventBus =
        widget.eventBus != null ? widget.eventBus! : GlobalEventBus.instance;

    _syncStatusSubscription = eventBus
        .on<WalletSyncStatusChangedEvent>()
        .listen((event) async {
          if (event.walletId == walletId) {
            switch (event.newStatus) {
              case WalletSyncStatus.unableToSync:
                // TODO: Handle this case.
                break;
              case WalletSyncStatus.synced:
                // TODO: Handle this case.
                break;
              case WalletSyncStatus.syncing:
                // TODO: Handle this case.
                break;
            }
            setState(() {
              _currentSyncStatus = event.newStatus;
            });
          }
        });

    // _nodeStatusSubscription =
    //     eventBus.on<NodeConnectionStatusChangedEvent>().listen(
    //   (event) async {
    //     if (event.walletId == widget.walletId) {
    //       switch (event.newStatus) {
    //         case NodeConnectionStatus.disconnected:
    //           // TODO: Handle this case.
    //           break;
    //         case NodeConnectionStatus.connected:
    //           // TODO: Handle this case.
    //           break;
    //         case NodeConnectionStatus.connecting:
    //           // TODO: Handle this case.
    //           break;
    //       }
    //       setState(() {
    //         _currentNodeStatus = event.newStatus;
    //       });
    //     }
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _nodeStatusSubscription.cancel();
    _syncStatusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    final wallet = ref.read(pWallets).getWallet(widget.walletId);

    bool canBackup = true;
    if (wallet is ViewOnlyOptionInterface &&
        wallet.isViewOnly &&
        wallet.viewOnlyType == ViewOnlyWalletType.addressOnly) {
      canBackup = false;
    }

    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Settings", style: STextStyles.navBarTitle(context)),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (builderContext, constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RoundedWhiteContainer(
                              padding: const EdgeInsets.all(4),
                              child: Column(
                                children: [
                                  SettingsListButton(
                                    iconAssetName: Assets.svg.addressBook,
                                    iconSize: 16,
                                    title: "Address book",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        AddressBookView.routeName,
                                        arguments: coin,
                                      );
                                    },
                                  ),
                                  if (coin is FrostCurrency)
                                    const SizedBox(height: 8),
                                  if (coin is FrostCurrency)
                                    SettingsListButton(
                                      iconAssetName: Assets.svg.addressBook2,
                                      iconSize: 16,
                                      title: "FROST Multisig settings",
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          FrostMSWalletOptionsView.routeName,
                                          arguments: walletId,
                                        );
                                      },
                                    ),
                                  const SizedBox(height: 8),
                                  SettingsListButton(
                                    iconAssetName: Assets.svg.node,
                                    iconSize: 16,
                                    title: "Network",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        WalletNetworkSettingsView.routeName,
                                        arguments: Tuple3(
                                          walletId,
                                          _currentSyncStatus,
                                          widget.initialNodeStatus,
                                        ),
                                      );
                                    },
                                  ),
                                  if (canBackup) const SizedBox(height: 8),
                                  if (canBackup)
                                    Consumer(
                                      builder: (_, ref, __) {
                                        return SettingsListButton(
                                          iconAssetName: Assets.svg.lock,
                                          iconSize: 16,
                                          title: "Wallet backup",
                                          onPressed: () async {
                                            // TODO: [prio=med] take wallets that don't have a mnemonic into account

                                            List<String>? mnemonic;
                                            ({
                                              String myName,
                                              String config,
                                              String keys,
                                              ({String config, String keys})?
                                              prevGen,
                                            })?
                                            frostWalletData;
                                            if (wallet is BitcoinFrostWallet) {
                                              final futures = [
                                                wallet.getSerializedKeys(),
                                                wallet.getMultisigConfig(),
                                                wallet
                                                    .getSerializedKeysPrevGen(),
                                                wallet
                                                    .getMultisigConfigPrevGen(),
                                              ];

                                              final results = await Future.wait(
                                                futures,
                                              );

                                              if (results.length == 4) {
                                                frostWalletData = (
                                                  myName:
                                                      wallet.frostInfo.myName,
                                                  config: results[1]!,
                                                  keys: results[0]!,
                                                  prevGen:
                                                      results[2] == null ||
                                                              results[3] == null
                                                          ? null
                                                          : (
                                                            config: results[3]!,
                                                            keys: results[2]!,
                                                          ),
                                                );
                                              }
                                            } else {
                                              if (wallet is MnemonicInterface) {
                                                if (wallet
                                                        is ViewOnlyOptionInterface &&
                                                    (wallet as ViewOnlyOptionInterface)
                                                        .isViewOnly) {
                                                  // TODO: is something needed here?
                                                } else {
                                                  mnemonic =
                                                      await wallet
                                                          .getMnemonicAsWords();
                                                }
                                              }
                                            }

                                            KeyDataInterface? keyData;
                                            if (wallet
                                                    is ViewOnlyOptionInterface &&
                                                wallet.isViewOnly) {
                                              keyData =
                                                  await wallet
                                                      .getViewOnlyWalletData();
                                            } else if (wallet
                                                is ExtendedKeysInterface) {
                                              keyData =
                                                  await wallet.getXPrivs();
                                            } else if (wallet
                                                is LibMoneroWallet) {
                                              keyData = await wallet.getKeys();
                                            }

                                            if (context.mounted) {
                                              if (keyData != null &&
                                                  wallet
                                                      is ViewOnlyOptionInterface &&
                                                  wallet.isViewOnly) {
                                                await Navigator.push(
                                                  context,
                                                  RouteGenerator.getRoute(
                                                    shouldUseMaterialRoute:
                                                        RouteGenerator
                                                            .useMaterialPageRoute,
                                                    builder:
                                                        (_) => LockscreenView(
                                                          routeOnSuccessArguments:
                                                              (
                                                                walletId:
                                                                    walletId,
                                                                keyData:
                                                                    keyData,
                                                              ),
                                                          showBackButton: true,
                                                          routeOnSuccess:
                                                              MobileKeyDataView
                                                                  .routeName,
                                                          biometricsCancelButtonString:
                                                              "CANCEL",
                                                          biometricsLocalizedReason:
                                                              "Authenticate to view recovery data",
                                                          biometricsAuthenticationTitle:
                                                              "View recovery data",
                                                        ),
                                                    settings: const RouteSettings(
                                                      name:
                                                          "/viewRecoveryDataLockscreen",
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                await Navigator.push(
                                                  context,
                                                  RouteGenerator.getRoute(
                                                    shouldUseMaterialRoute:
                                                        RouteGenerator
                                                            .useMaterialPageRoute,
                                                    builder:
                                                        (_) => LockscreenView(
                                                          routeOnSuccessArguments: (
                                                            walletId: walletId,
                                                            mnemonic:
                                                                mnemonic ?? [],
                                                            frostWalletData:
                                                                frostWalletData,
                                                            keyData: keyData,
                                                          ),
                                                          showBackButton: true,
                                                          routeOnSuccess:
                                                              WalletBackupView
                                                                  .routeName,
                                                          biometricsCancelButtonString:
                                                              "CANCEL",
                                                          biometricsLocalizedReason:
                                                              "Authenticate to view recovery phrase",
                                                          biometricsAuthenticationTitle:
                                                              "View recovery phrase",
                                                        ),
                                                    settings: const RouteSettings(
                                                      name:
                                                          "/viewRecoverPhraseLockscreen",
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  const SizedBox(height: 8),
                                  SettingsListButton(
                                    iconAssetName: Assets.svg.downloadFolder,
                                    title: "Wallet settings",
                                    iconSize: 16,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        WalletSettingsWalletSettingsView
                                            .routeName,
                                        arguments: walletId,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  SettingsListButton(
                                    iconAssetName: Assets.svg.arrowRotate,
                                    title: "Syncing preferences",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        SyncingPreferencesView.routeName,
                                      );
                                    },
                                  ),
                                  if (xPubEnabled) const SizedBox(height: 8),
                                  if (xPubEnabled)
                                    Consumer(
                                      builder: (_, ref, __) {
                                        return SettingsListButton(
                                          iconAssetName: Assets.svg.eye,
                                          title: "Wallet xPub",
                                          onPressed: () async {
                                            final xpubData = await showLoading(
                                              delay: const Duration(
                                                milliseconds: 800,
                                              ),
                                              whileFuture:
                                                  (ref
                                                              .read(pWallets)
                                                              .getWallet(
                                                                walletId,
                                                              )
                                                          as ExtendedKeysInterface)
                                                      .getXPubs(),
                                              context: context,
                                              message: "Loading xpubs",
                                              rootNavigator: Util.isDesktop,
                                            );
                                            if (context.mounted) {
                                              await Navigator.of(
                                                context,
                                              ).pushNamed(
                                                XPubView.routeName,
                                                arguments: (
                                                  widget.walletId,
                                                  xpubData,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  if (coin is Firo) const SizedBox(height: 8),
                                  if (coin is Firo)
                                    Consumer(
                                      builder: (_, ref, __) {
                                        return SettingsListButton(
                                          iconAssetName: Assets.svg.eye,
                                          title: "Clear electrumx cache",
                                          onPressed: () async {
                                            String? result;
                                            await showDialog<void>(
                                              useSafeArea: false,
                                              barrierDismissible: true,
                                              context: context,
                                              builder:
                                                  (_) => StackOkDialog(
                                                    title:
                                                        "Are you sure you want to clear "
                                                        "${coin.prettyName} electrumx cache?",
                                                    onOkPressed: (value) {
                                                      result = value;
                                                    },
                                                    leftButton: SecondaryButton(
                                                      label: "Cancel",
                                                      onPressed: () {
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                    ),
                                                  ),
                                            );

                                            if (result == "OK" &&
                                                context.mounted) {
                                              await showLoading(
                                                whileFuture: Future.wait<void>([
                                                  Future.delayed(
                                                    const Duration(
                                                      milliseconds: 1500,
                                                    ),
                                                  ),
                                                  DB.instance
                                                      .clearSharedTransactionCache(
                                                        currency: coin,
                                                      ),
                                                  if (coin is Firo)
                                                    FiroCacheCoordinator.clearSharedCache(
                                                      coin.network,
                                                    ),
                                                ]),
                                                context: context,
                                                message: "Clearing cache...",
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  if (coin is NanoCurrency)
                                    const SizedBox(height: 8),
                                  if (coin is NanoCurrency)
                                    Consumer(
                                      builder: (_, ref, __) {
                                        return SettingsListButton(
                                          iconAssetName: Assets.svg.eye,
                                          title: "Change representative",
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              ChangeRepresentativeView
                                                  .routeName,
                                              arguments: widget.walletId,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // SettingsListButton(
                                  //   iconAssetName: Assets.svg.ellipsis,
                                  //   title: "Debug Info",
                                  //   onPressed: () {
                                  //     Navigator.of(context)
                                  //         .pushNamed(DebugView.routeName);
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Spacer(),
                            Consumer(
                              builder: (_, ref, __) {
                                return TextButton(
                                  onPressed: () {
                                    // TODO: [prio=med] needs more thought if this is still required
                                    // ref
                                    //     .read(pWallets)
                                    //     .getWallet(walletId)
                                    //     .isActiveWallet = false;
                                    ref
                                        .read(transactionFilterProvider.state)
                                        .state = null;

                                    Navigator.of(context).popUntil(
                                      ModalRoute.withName(HomeView.routeName),
                                    );
                                  },
                                  style: Theme.of(context)
                                      .extension<StackColors>()!
                                      .getSecondaryEnabledButtonStyle(context),
                                  child: Text(
                                    "Log out",
                                    style: STextStyles.button(context).copyWith(
                                      color:
                                          Theme.of(context)
                                              .extension<StackColors>()!
                                              .accentColorDark,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EpicBoxInfoForm extends ConsumerStatefulWidget {
  const EpicBoxInfoForm({super.key, required this.walletId});

  final String walletId;

  @override
  ConsumerState<EpicBoxInfoForm> createState() => _EpiBoxInfoFormState();
}

class _EpiBoxInfoFormState extends ConsumerState<EpicBoxInfoForm> {
  final hostController = TextEditingController();
  final portController = TextEditingController();

  late EpiccashWallet wallet;

  @override
  void initState() {
    wallet = ref.read(pWallets).getWallet(widget.walletId) as EpiccashWallet;

    wallet.getEpicBoxConfig().then((EpicBoxConfigModel epicBoxConfig) {
      hostController.text = epicBoxConfig.host;
      portController.text = "${epicBoxConfig.port ?? 443}";
    });
    super.initState();
  }

  @override
  void dispose() {
    hostController.dispose();
    portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedWhiteContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            autocorrect: Util.isDesktop ? false : true,
            enableSuggestions: Util.isDesktop ? false : true,
            controller: hostController,
            decoration: const InputDecoration(hintText: "Host"),
          ),
          const SizedBox(height: 8),
          TextField(
            autocorrect: Util.isDesktop ? false : true,
            enableSuggestions: Util.isDesktop ? false : true,
            controller: portController,
            decoration: const InputDecoration(hintText: "Port"),
            keyboardType:
                Util.isDesktop ? null : const TextInputType.numberWithOptions(),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () async {
              try {
                await wallet.updateEpicboxConfig(
                  hostController.text,
                  int.parse(portController.text),
                );
                if (mounted) {
                  await showFloatingFlushBar(
                    context: context,
                    message: "Epicbox info saved!",
                    type: FlushBarType.success,
                  );
                }
                unawaited(wallet.refresh());
              } catch (e) {
                await showFloatingFlushBar(
                  context: context,
                  message: "Failed to save epicbox info: $e",
                  type: FlushBarType.warning,
                );
              }
            },
            child: Text(
              "Save",
              style: STextStyles.button(context).copyWith(
                color:
                    Theme.of(context).extension<StackColors>()!.accentColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
