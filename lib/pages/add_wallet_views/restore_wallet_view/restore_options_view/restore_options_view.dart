/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:cs_monero/src/deprecated/get_height_by_date.dart'
    as cs_monero_deprecated;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

import '../../../../pages_desktop_specific/my_stack_view/exit_to_my_stack_button.dart';
import '../../../../providers/ui/verify_recovery_phrase/mnemonic_word_count_state_provider.dart';
import '../../../../themes/stack_colors.dart';
import '../../../../utilities/assets.dart';
import '../../../../utilities/constants.dart';
import '../../../../utilities/format.dart';
import '../../../../utilities/logger.dart';
import '../../../../utilities/text_styles.dart';
import '../../../../utilities/util.dart';
import '../../../../wallets/crypto_currency/crypto_currency.dart';
import '../../../../wallets/crypto_currency/interfaces/view_only_option_currency_interface.dart';
import '../../../../wallets/crypto_currency/intermediate/cryptonote_currency.dart';
import '../../../../widgets/conditional_parent.dart';
import '../../../../widgets/custom_buttons/app_bar_icon_button.dart';
import '../../../../widgets/custom_buttons/blue_text_button.dart';
import '../../../../widgets/custom_buttons/checkbox_text_button.dart';
import '../../../../widgets/date_picker/date_picker.dart';
import '../../../../widgets/desktop/desktop_app_bar.dart';
import '../../../../widgets/desktop/desktop_scaffold.dart';
import '../../../../widgets/expandable.dart';
import '../../../../widgets/icon_widgets/x_icon.dart';
import '../../../../widgets/rounded_white_container.dart';
import '../../../../widgets/stack_text_field.dart';
import '../../../../widgets/textfield_icon_button.dart';
import '../../../../widgets/toggle.dart';
import '../../create_or_restore_wallet_view/sub_widgets/coin_image.dart';
import '../restore_view_only_wallet_view.dart';
import '../restore_wallet_view.dart';
import '../sub_widgets/mnemonic_word_count_select_sheet.dart';
import 'sub_widgets/mobile_mnemonic_length_selector.dart';
import 'sub_widgets/restore_from_date_picker.dart';
import 'sub_widgets/restore_options_next_button.dart';
import 'sub_widgets/restore_options_platform_layout.dart';

final _pIsUsingDate = StateProvider.autoDispose((_) => true);

class RestoreOptionsView extends ConsumerStatefulWidget {
  const RestoreOptionsView({
    super.key,
    required this.walletName,
    required this.coin,
  });

  static const routeName = "/restoreOptions";

  final String walletName;
  final CryptoCurrency coin;

  @override
  ConsumerState<RestoreOptionsView> createState() => _RestoreOptionsViewState();
}

class _RestoreOptionsViewState extends ConsumerState<RestoreOptionsView> {
  late final String walletName;
  late final CryptoCurrency coin;
  late final bool isDesktop;

  late TextEditingController _dateController;
  late TextEditingController _blockHeightController;
  late FocusNode _blockHeightFocusNode;
  late FocusNode textFieldFocusNode;
  late final FocusNode passwordFocusNode;
  late final TextEditingController passwordController;

  bool _hasBlockHeight = false;
  DateTime? _restoreFromDate;
  bool hidePassword = true;

  bool enableLelantusScanning = false;
  bool get supportsLelantus => coin is Firo;

  @override
  void initState() {
    super.initState();
    walletName = widget.walletName;
    coin = widget.coin;
    isDesktop = Util.isDesktop;

    _dateController = TextEditingController();
    textFieldFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    _blockHeightController = TextEditingController();
    _blockHeightFocusNode = FocusNode();

    _blockHeightController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (!ref.read(_pIsUsingDate)) {
            setState(() {
              _hasBlockHeight = _blockHeightController.text.isNotEmpty;
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _blockHeightController.dispose();
    textFieldFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool _nextLock = false;
  Future<void> nextPressed() async {
    if (_nextLock) return;
    _nextLock = true;
    try {
      if (!isDesktop) {
        // hide keyboard if has focus
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          await Future<void>.delayed(const Duration(milliseconds: 75));
        }
      }

      if (mounted) {
        int height = 0;
        if (ref.read(_pIsUsingDate)) {
          height = getBlockHeightFromDate(_restoreFromDate);
        } else {
          height = int.tryParse(_blockHeightController.text) ?? 0;
        }
        if (!_showViewOnlyOption) {
          await Navigator.of(context).pushNamed(
            RestoreWalletView.routeName,
            arguments: Tuple6(
              walletName,
              coin,
              ref.read(mnemonicWordCountStateProvider.state).state,
              height,
              passwordController.text,
              enableLelantusScanning,
            ),
          );
        } else {
          await Navigator.of(context).pushNamed(
            RestoreViewOnlyWalletView.routeName,
            arguments: (
              walletName: walletName,
              coin: coin,
              restoreBlockHeight: height,
              enableLelantusScanning: enableLelantusScanning,
            ),
          );
        }
      }
    } finally {
      _nextLock = false;
    }
  }

  Future<void> chooseDate() async {
    // check and hide keyboard
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
      await Future<void>.delayed(const Duration(milliseconds: 125));
    }

    if (mounted) {
      final date = await showSWDatePicker(context);
      if (date != null) {
        _restoreFromDate = date;
        _dateController.text = Format.formatDate(date);
      }
    }
  }

  Future<void> chooseDesktopDate() async {
    final date = await showSWDatePicker(context);
    if (date != null) {
      _restoreFromDate = date;
      _dateController.text = Format.formatDate(date);
    }
  }

  Future<void> chooseMnemonicLength() async {
    await showModalBottomSheet<dynamic>(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return MnemonicWordCountSelectSheet(
          lengthOptions: coin.possibleMnemonicLengths,
        );
      },
    );
  }

  int getBlockHeightFromDate(DateTime? date) {
    try {
      int height = 0;
      if (date != null) {
        if (widget.coin is Monero) {
          height = cs_monero_deprecated.getMoneroHeightByDate(date: date);
        }
        if (widget.coin is Wownero) {
          height = cs_monero_deprecated.getWowneroHeightByDate(date: date);
        }
        if (height < 0) {
          height = 0;
        }

        if (widget.coin is Epiccash) {
          final int secondsSinceEpoch = date.millisecondsSinceEpoch ~/ 1000;
          const int epicCashFirstBlock = 1565370278;
          const double overestimateSecondsPerBlock = 61;
          final int chosenSeconds = secondsSinceEpoch - epicCashFirstBlock;
          final int approximateHeight =
              chosenSeconds ~/ overestimateSecondsPerBlock;

          height = approximateHeight;
          if (height < 0) {
            height = 0;
          }
        }
      } else {
        height = 0;
      }
      return height;
    } catch (e) {
      Logging.instance.log(
        Level.info,
        "Error getting block height from date: $e",
      );
      return 0;
    }
  }

  bool _showViewOnlyOption = false;

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType with ${coin.identifier} $walletName");

    return MasterScaffold(
      isDesktop: isDesktop,
      appBar:
          isDesktop
              ? const DesktopAppBar(
                isCompactHeight: false,
                leading: AppBarBackButton(),
                trailing: ExitToMyStackButton(),
              )
              : AppBar(
                leading: AppBarBackButton(
                  onPressed: () {
                    if (textFieldFocusNode.hasFocus) {
                      textFieldFocusNode.unfocus();
                      Future<void>.delayed(
                        const Duration(milliseconds: 100),
                      ).then((value) => Navigator.of(context).pop());
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
      body: RestoreOptionsPlatformLayout(
        isDesktop: isDesktop,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 480 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(flex: isDesktop ? 10 : 1),
              if (!isDesktop) CoinImage(coin: coin, height: 100, width: 100),
              SizedBox(height: isDesktop ? 0 : 16),
              Text(
                "Restore options",
                textAlign: TextAlign.center,
                style:
                    isDesktop
                        ? STextStyles.desktopH2(context)
                        : STextStyles.pageTitleH1(context),
              ),
              SizedBox(height: isDesktop ? 40 : 24),
              if (coin is ViewOnlyOptionCurrencyInterface)
                SizedBox(
                  height: isDesktop ? 56 : 48,
                  width: isDesktop ? 490 : null,
                  child: Toggle(
                    key: UniqueKey(),
                    onText: "Seed",
                    offText: "View Only",
                    onColor:
                        Theme.of(context).extension<StackColors>()!.popupBG,
                    offColor:
                        Theme.of(
                          context,
                        ).extension<StackColors>()!.textFieldDefaultBG,
                    isOn: _showViewOnlyOption,
                    onValueChanged: (value) {
                      setState(() {
                        _showViewOnlyOption = value;
                      });
                    },
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        Constants.size.circularBorderRadius,
                      ),
                    ),
                  ),
                ),
              if (coin is ViewOnlyOptionCurrencyInterface)
                SizedBox(height: isDesktop ? 40 : 24),
              _showViewOnlyOption
                  ? ViewOnlyRestoreOption(
                    coin: coin,
                    dateController: _dateController,
                    dateChooserFunction:
                        isDesktop ? chooseDesktopDate : chooseDate,
                    blockHeightController: _blockHeightController,
                    blockHeightFocusNode: _blockHeightFocusNode,
                  )
                  : SeedRestoreOption(
                    coin: coin,
                    dateController: _dateController,
                    blockHeightController: _blockHeightController,
                    blockHeightFocusNode: _blockHeightFocusNode,
                    pwController: passwordController,
                    pwFocusNode: passwordFocusNode,
                    dateChooserFunction:
                        isDesktop ? chooseDesktopDate : chooseDate,
                    chooseMnemonicLength: chooseMnemonicLength,
                    lelScanChanged: (value) {
                      enableLelantusScanning = value;
                    },
                  ),
              if (!isDesktop) const Spacer(flex: 3),
              SizedBox(height: isDesktop ? 32 : 12),
              RestoreOptionsNextButton(
                isDesktop: isDesktop,
                onPressed:
                    ref.watch(_pIsUsingDate) || _hasBlockHeight
                        ? nextPressed
                        : null,
              ),
              if (isDesktop) const Spacer(flex: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class SeedRestoreOption extends ConsumerStatefulWidget {
  const SeedRestoreOption({
    super.key,
    required this.coin,
    required this.dateController,
    required this.blockHeightController,
    required this.blockHeightFocusNode,
    required this.pwController,
    required this.pwFocusNode,
    required this.dateChooserFunction,
    required this.chooseMnemonicLength,
    required this.lelScanChanged,
  });

  final CryptoCurrency coin;
  final TextEditingController dateController;
  final TextEditingController blockHeightController;
  final FocusNode blockHeightFocusNode;
  final TextEditingController pwController;
  final FocusNode pwFocusNode;

  final Future<void> Function() dateChooserFunction;
  final Future<void> Function() chooseMnemonicLength;
  final void Function(bool) lelScanChanged;

  @override
  ConsumerState<SeedRestoreOption> createState() => _SeedRestoreOptionState();
}

class _SeedRestoreOptionState extends ConsumerState<SeedRestoreOption> {
  bool _hidePassword = true;
  bool _expandedAdvanced = false;
  bool _enableLelantusScanning = false;
  bool _blockFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    final lengths = widget.coin.possibleMnemonicLengths;

    final currentLength = ref.watch(mnemonicWordCountStateProvider);

    final isMoneroAnd25 = widget.coin is Monero && currentLength == 25;
    final isWowneroAnd25 = widget.coin is Wownero && currentLength == 25;

    final bool supportsPassphrase;
    if (widget.coin.hasMnemonicPassphraseSupport) {
      supportsPassphrase = true;
    } else if (widget.coin is CryptonoteCurrency) {
      // partial see offset support. Currently only on restore
      // and not wownero 14 word seeds
      supportsPassphrase = currentLength == 16 || currentLength == 25;
    } else {
      supportsPassphrase = false;
    }

    return Column(
      children: [
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.watch(_pIsUsingDate) ? "Choose start date" : "Block height",
                style:
                    Util.isDesktop
                        ? STextStyles.desktopTextExtraSmall(context).copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<StackColors>()!.textDark3,
                        )
                        : STextStyles.smallMed12(context),
                textAlign: TextAlign.left,
              ),
              CustomTextButton(
                text:
                    ref.watch(_pIsUsingDate) ? "Use block height" : "Use date",
                onTap:
                    () =>
                        ref.read(_pIsUsingDate.notifier).state =
                            !ref.read(_pIsUsingDate),
              ),
            ],
          ),
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          SizedBox(height: Util.isDesktop ? 16 : 8),
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          ref.watch(_pIsUsingDate)
              ? RestoreFromDatePicker(
                onTap: widget.dateChooserFunction,
                controller: widget.dateController,
              )
              : ClipRRect(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
                child: TextField(
                  focusNode: widget.blockHeightFocusNode,
                  controller: widget.blockHeightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  style:
                      Util.isDesktop
                          ? STextStyles.desktopTextMedium(
                            context,
                          ).copyWith(height: 2)
                          : STextStyles.field(context),
                  onChanged: (value) {
                    setState(() {
                      _blockFieldEmpty = value.isEmpty;
                    });
                  },
                  decoration: standardInputDecoration(
                    "Start scanning from...",
                    widget.blockHeightFocusNode,
                    context,
                  ).copyWith(
                    suffixIcon: UnconstrainedBox(
                      child: TextFieldIconButton(
                        child: Semantics(
                          label:
                              "Clear Block Height Field Button. Clears the block height field",
                          excludeSemantics: true,
                          child:
                              !_blockFieldEmpty
                                  ? XIcon(
                                    width: Util.isDesktop ? 24 : 16,
                                    height: Util.isDesktop ? 24 : 16,
                                  )
                                  : const SizedBox.shrink(),
                        ),
                        onTap: () {
                          widget.blockHeightController.text = "";
                          setState(() {
                            _blockFieldEmpty = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          const SizedBox(height: 8),
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          RoundedWhiteContainer(
            child: Center(
              child: Text(
                ref.watch(_pIsUsingDate)
                    ? "Choose the date you made the wallet (approximate is fine)"
                    : "Enter the initial block height of the wallet",
                style:
                    Util.isDesktop
                        ? STextStyles.desktopTextExtraSmall(context).copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<StackColors>()!.textSubtitle1,
                        )
                        : STextStyles.smallMed12(
                          context,
                        ).copyWith(fontSize: 10),
              ),
            ),
          ),
        if (isMoneroAnd25 || widget.coin is Epiccash || isWowneroAnd25)
          SizedBox(height: Util.isDesktop ? 24 : 16),
        Text(
          "Choose recovery phrase length",
          style:
              Util.isDesktop
                  ? STextStyles.desktopTextExtraSmall(context).copyWith(
                    color:
                        Theme.of(context).extension<StackColors>()!.textDark3,
                  )
                  : STextStyles.smallMed12(context),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: Util.isDesktop ? 16 : 8),
        if (Util.isDesktop)
          DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              value: ref.watch(mnemonicWordCountStateProvider.state).state,
              items: [
                ...lengths.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      "$e words",
                      style: STextStyles.desktopTextMedium(context),
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value is int) {
                  ref.read(mnemonicWordCountStateProvider.state).state = value;
                }
              },
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: ConditionalParent(
                  condition: Util.isDesktop,
                  builder:
                      (child) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: child,
                      ),
                  child: SvgPicture.asset(
                    Assets.svg.chevronDown,
                    width: 12,
                    height: 6,
                    color:
                        Theme.of(context)
                            .extension<StackColors>()!
                            .textFieldActiveSearchIconRight,
                  ),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                offset: const Offset(0, -10),
                elevation: 0,
                decoration: BoxDecoration(
                  color:
                      Theme.of(
                        context,
                      ).extension<StackColors>()!.textFieldDefaultBG,
                  borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius,
                  ),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        if (!Util.isDesktop)
          MobileMnemonicLengthSelector(
            chooseMnemonicLength: widget.chooseMnemonicLength,
          ),
        if (supportsPassphrase) SizedBox(height: Util.isDesktop ? 24 : 16),
        if (supportsPassphrase)
          Expandable(
            onExpandChanged: (state) {
              setState(() {
                _expandedAdvanced = state == ExpandableState.expanded;
              });
            },
            header: Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 10,
                  left: Util.isDesktop ? 16 : 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Advanced",
                      style:
                          Util.isDesktop
                              ? STextStyles.desktopTextExtraExtraSmall(
                                context,
                              ).copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).extension<StackColors>()!.textDark3,
                              )
                              : STextStyles.smallMed12(context),
                      textAlign: TextAlign.left,
                    ),
                    SvgPicture.asset(
                      _expandedAdvanced
                          ? Assets.svg.chevronUp
                          : Assets.svg.chevronDown,
                      width: 12,
                      height: 6,
                      color:
                          Theme.of(context)
                              .extension<StackColors>()!
                              .textFieldActiveSearchIconRight,
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  if (widget.coin is Firo)
                    CheckboxTextButton(
                      label: "Scan for Lelantus transactions",
                      onChanged: (newValue) {
                        setState(() {
                          _enableLelantusScanning = newValue ?? true;
                        });

                        widget.lelScanChanged(_enableLelantusScanning);
                      },
                    ),
                  if (widget.coin is Firo) const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Constants.size.circularBorderRadius,
                    ),
                    child: TextField(
                      key: const Key("mnemonicPassphraseFieldKey1"),
                      focusNode: widget.pwFocusNode,
                      controller: widget.pwController,
                      style:
                          Util.isDesktop
                              ? STextStyles.desktopTextMedium(
                                context,
                              ).copyWith(height: 2)
                              : STextStyles.field(context),
                      obscureText: _hidePassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: standardInputDecoration(
                        widget.coin is CryptonoteCurrency
                            ? "Seed Offset"
                            : "BIP39 passphrase",
                        widget.pwFocusNode,
                        context,
                      ).copyWith(
                        suffixIcon: UnconstrainedBox(
                          child: ConditionalParent(
                            condition: Util.isDesktop,
                            builder:
                                (child) => SizedBox(height: 70, child: child),
                            child: Row(
                              children: [
                                SizedBox(width: Util.isDesktop ? 24 : 16),
                                GestureDetector(
                                  key: const Key(
                                    "mnemonicPassphraseFieldShowPasswordButtonKey",
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    _hidePassword
                                        ? Assets.svg.eye
                                        : Assets.svg.eyeSlash,
                                    color:
                                        Theme.of(
                                          context,
                                        ).extension<StackColors>()!.textDark3,
                                    width: Util.isDesktop ? 24 : 16,
                                    height: Util.isDesktop ? 24 : 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RoundedWhiteContainer(
                    child: Center(
                      child: Text(
                        widget.coin is CryptonoteCurrency
                            ? "(Optional) An offset used to derive a different "
                                "wallet from the given mnemonic, allowing recovery "
                                "of a hidden or alternate wallet based on the same "
                                "seed phrase."
                            : "If the recovery phrase you are about to restore "
                                "was created with an optional BIP39 passphrase "
                                "you can enter it here.",
                        style:
                            Util.isDesktop
                                ? STextStyles.desktopTextExtraSmall(
                                  context,
                                ).copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).extension<StackColors>()!.textSubtitle1,
                                )
                                : STextStyles.itemSubtitle(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _blockFieldEmpty = widget.blockHeightController.text.isEmpty;
  }
}

class ViewOnlyRestoreOption extends ConsumerStatefulWidget {
  const ViewOnlyRestoreOption({
    super.key,
    required this.coin,
    required this.dateController,
    required this.dateChooserFunction,
    required this.blockHeightController,
    required this.blockHeightFocusNode,
  });

  final CryptoCurrency coin;
  final TextEditingController dateController;
  final TextEditingController blockHeightController;
  final FocusNode blockHeightFocusNode;

  final Future<void> Function() dateChooserFunction;

  @override
  ConsumerState<ViewOnlyRestoreOption> createState() =>
      _ViewOnlyRestoreOptionState();
}

class _ViewOnlyRestoreOptionState extends ConsumerState<ViewOnlyRestoreOption> {
  bool _blockFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    final showDateOption = widget.coin is CryptonoteCurrency;
    return Column(
      children: [
        if (showDateOption)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.watch(_pIsUsingDate) ? "Choose start date" : "Block height",
                style:
                    Util.isDesktop
                        ? STextStyles.desktopTextExtraExtraSmall(
                          context,
                        ).copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<StackColors>()!.textDark3,
                        )
                        : STextStyles.smallMed12(context),
                textAlign: TextAlign.left,
              ),
              CustomTextButton(
                text:
                    ref.watch(_pIsUsingDate) ? "Use block height" : "Use date",
                onTap: () {
                  ref.read(_pIsUsingDate.notifier).state =
                      !ref.read(_pIsUsingDate);
                },
              ),
            ],
          ),
        if (showDateOption) SizedBox(height: Util.isDesktop ? 16 : 8),
        if (showDateOption)
          ref.watch(_pIsUsingDate)
              ? RestoreFromDatePicker(
                onTap: widget.dateChooserFunction,
                controller: widget.dateController,
              )
              : ClipRRect(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
                child: TextField(
                  focusNode: widget.blockHeightFocusNode,
                  controller: widget.blockHeightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  style:
                      Util.isDesktop
                          ? STextStyles.desktopTextMedium(
                            context,
                          ).copyWith(height: 2)
                          : STextStyles.field(context),
                  onChanged: (value) {
                    setState(() {
                      _blockFieldEmpty = value.isEmpty;
                    });
                  },
                  decoration: standardInputDecoration(
                    "Start scanning from...",
                    widget.blockHeightFocusNode,
                    context,
                  ).copyWith(
                    suffixIcon: UnconstrainedBox(
                      child: TextFieldIconButton(
                        child: Semantics(
                          label:
                              "Clear Block Height Field Button. Clears the block height field",
                          excludeSemantics: true,
                          child:
                              !_blockFieldEmpty
                                  ? XIcon(
                                    width: Util.isDesktop ? 24 : 16,
                                    height: Util.isDesktop ? 24 : 16,
                                  )
                                  : const SizedBox.shrink(),
                        ),
                        onTap: () {
                          widget.blockHeightController.text = "";
                          setState(() {
                            _blockFieldEmpty = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
        if (showDateOption) const SizedBox(height: 8),
        if (showDateOption)
          RoundedWhiteContainer(
            child: Center(
              child: Text(
                ref.watch(_pIsUsingDate)
                    ? "Choose the date you made the wallet (approximate is fine)"
                    : "Enter the initial block height of the wallet",
                style:
                    Util.isDesktop
                        ? STextStyles.desktopTextExtraSmall(context).copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<StackColors>()!.textSubtitle1,
                        )
                        : STextStyles.smallMed12(
                          context,
                        ).copyWith(fontSize: 10),
              ),
            ),
          ),
        if (showDateOption) SizedBox(height: Util.isDesktop ? 24 : 16),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _blockFieldEmpty = widget.blockHeightController.text.isEmpty;
  }
}
