import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../notifications/show_flush_bar.dart';
import '../../../../../providers/global/prefs_provider.dart';
import '../../../../../providers/global/secure_store_provider.dart';
import '../../../../../themes/stack_colors.dart';
import '../../../../../utilities/assets.dart';
import '../../../../../utilities/flutter_secure_storage_interface.dart';
import '../../../../../utilities/text_styles.dart';
import '../../../../../widgets/background.dart';
import '../../../../../widgets/custom_buttons/app_bar_icon_button.dart';
import '../../../../../widgets/custom_pin_put/custom_pin_put.dart';
import '../../../pinpad_views/lock_screen_view.dart';
import 'security_view.dart';

class CreateDuressPinView extends ConsumerStatefulWidget {
  const CreateDuressPinView({super.key});

  static const String routeName = "/createDuressPinView";

  @override
  ConsumerState<CreateDuressPinView> createState() =>
      _CreateDuressPinViewState();
}

class _CreateDuressPinViewState extends ConsumerState<CreateDuressPinView> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Theme.of(context).extension<StackColors>()!.infoItemIcons,
      border: Border.all(
        width: 1,
        color: Theme.of(context).extension<StackColors>()!.infoItemIcons,
      ),
      borderRadius: BorderRadius.circular(6),
    );
  }

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  // Attributes for Page 1 of the page view
  final TextEditingController _pinPutController1 = TextEditingController();
  final FocusNode _pinPutFocusNode1 = FocusNode();

  // Attributes for Page 2 of the page view
  final TextEditingController _pinPutController2 = TextEditingController();
  final FocusNode _pinPutFocusNode2 = FocusNode();

  late final SecureStorageInterface _secureStore;

  int pinCount = 1;

  @override
  void initState() {
    super.initState();
    _secureStore = ref.read(secureStoreProvider);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pinPutController1.dispose();
    _pinPutController2.dispose();
    _pinPutFocusNode1.dispose();
    _pinPutFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () async {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
                await Future<void>.delayed(const Duration(milliseconds: 70));
              }
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // page 1
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Create duress PIN",
                      style: STextStyles.pageTitleH1(context),
                    ),
                  ),
                  const SizedBox(height: 52),
                  CustomPinPut(
                    fieldsCount: pinCount,
                    eachFieldHeight: 12,
                    eachFieldWidth: 12,
                    textStyle: STextStyles.label(context).copyWith(fontSize: 1),
                    focusNode: _pinPutFocusNode1,
                    controller: _pinPutController1,
                    useNativeKeyboard: false,
                    obscureText: "",
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      fillColor:
                          Theme.of(
                            context,
                          ).extension<StackColors>()!.background,
                      counterText: "",
                    ),
                    isRandom:
                        ref.read(prefsChangeNotifierProvider).randomizePIN,
                    submittedFieldDecoration: _pinPutDecoration,
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration,
                    onSubmit: (String pin) {
                      if (pin.length < 4) {
                        showFloatingFlushBar(
                          type: FlushBarType.warning,
                          message: "PIN not long enough!",
                          iconAsset: Assets.svg.alertCircle,
                          context: context,
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      }
                    },
                  ),
                ],
              ),

              // page 2
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Confirm duress PIN",
                      style: STextStyles.pageTitleH1(context),
                    ),
                  ),
                  const SizedBox(height: 52),
                  CustomPinPut(
                    fieldsCount: pinCount,
                    eachFieldHeight: 12,
                    eachFieldWidth: 12,
                    textStyle: STextStyles.infoSmall(context).copyWith(
                      color:
                          Theme.of(
                            context,
                          ).extension<StackColors>()!.textSubtitle3,
                      fontSize: 1,
                    ),
                    focusNode: _pinPutFocusNode2,
                    controller: _pinPutController2,
                    useNativeKeyboard: false,
                    obscureText: "",
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      fillColor:
                          Theme.of(
                            context,
                          ).extension<StackColors>()!.background,
                      counterText: "",
                    ),
                    isRandom:
                        ref.read(prefsChangeNotifierProvider).randomizePIN,
                    submittedFieldDecoration: _pinPutDecoration,
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration,
                    onSubmit: (String pin) async {
                      if (_pinPutController1.text == _pinPutController2.text) {
                        await _secureStore.write(
                          key: kDuressPinKey,
                          value: pin,
                        );
                        ref.read(prefsChangeNotifierProvider).hasDuressPin =
                            true;

                        if (context.mounted) {
                          unawaited(
                            showFloatingFlushBar(
                              type: FlushBarType.success,
                              message: "Duress PIN is set up",
                              context: context,
                              iconAsset: Assets.svg.check,
                            ),
                          );
                        }

                        await Future<void>.delayed(
                          const Duration(milliseconds: 1200),
                        );

                        if (context.mounted) {
                          Navigator.of(context).popUntil(
                            ModalRoute.withName(SecurityView.routeName),
                          );
                        }
                      } else {
                        unawaited(
                          _pageController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          ),
                        );
                        unawaited(
                          showFloatingFlushBar(
                            type: FlushBarType.warning,
                            message: "PIN codes do not match. Try again.",
                            context: context,
                            iconAsset: Assets.svg.alertCircle,
                          ),
                        );

                        _pinPutController1.text = '';
                        _pinPutController2.text = '';
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
