/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_config.dart';
import '../../../providers/global/prefs_provider.dart';
import '../../../providers/ui/address_book_providers/address_book_filter_provider.dart';
import '../../../themes/stack_colors.dart';
import '../../../utilities/text_styles.dart';
import '../../../utilities/util.dart';
import '../../../wallets/crypto_currency/crypto_currency.dart';
import '../../../widgets/background.dart';
import '../../../widgets/conditional_parent.dart';
import '../../../widgets/custom_buttons/app_bar_icon_button.dart';
import '../../../widgets/desktop/desktop_dialog_close_button.dart';
import '../../../widgets/desktop/primary_button.dart';
import '../../../widgets/desktop/secondary_button.dart';
import '../../../widgets/rounded_white_container.dart';

class AddressBookFilterView extends ConsumerStatefulWidget {
  const AddressBookFilterView({super.key});

  static const String routeName = "/addressBookFilter";

  @override
  ConsumerState<AddressBookFilterView> createState() =>
      _AddressBookFilterViewState();
}

class _AddressBookFilterViewState extends ConsumerState<AddressBookFilterView> {
  late final List<CryptoCurrency> _coins;

  @override
  void initState() {
    final coins = [...AppConfig.coins];
    coins.removeWhere((e) => e is Firo && e.network.isTestNet);

    final showTestNet = ref.read(prefsChangeNotifierProvider).showTestNetCoins;

    if (showTestNet) {
      _coins = coins.toList(growable: false);
    } else {
      _coins = coins
          .where((e) => e.network != CryptoCurrencyNetwork.test)
          .toList(growable: false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;
    return ConditionalParent(
      condition: !isDesktop,
      builder: (child) {
        return Background(
          child: Scaffold(
            backgroundColor:
                Theme.of(context).extension<StackColors>()!.background,
            appBar: AppBar(
              backgroundColor:
                  Theme.of(context).extension<StackColors>()!.background,
              leading: AppBarBackButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "Filter addresses",
                style: STextStyles.navBarTitle(context),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: LayoutBuilder(
                  builder: (builderContext, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RoundedWhiteContainer(
                                  child: Text(
                                    "Only selected cryptocurrency addresses will be displayed.",
                                    style: STextStyles.itemSubtitle(context),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Select cryptocurrency",
                                  style: STextStyles.smallMed12(context),
                                ),
                                const SizedBox(height: 12),
                                child,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      child: ConditionalParent(
        condition: isDesktop,
        builder: (child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      "Select cryptocurrency",
                      style: STextStyles.desktopH3(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const DesktopDialogCloseButton(),
                ],
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: child,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryButton(
                      width: 248,
                      buttonHeight: ButtonHeight.l,
                      enabled: true,
                      label: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    // const SizedBox(width: 16),
                    PrimaryButton(
                      width: 248,
                      buttonHeight: ButtonHeight.l,
                      enabled: true,
                      label: "Apply",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        child: RoundedWhiteContainer(
          padding: const EdgeInsets.all(0),
          child: Wrap(
            children: [
              ..._coins.map(
                (coin) => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ref
                            .read(addressBookFilterProvider)
                            .coins
                            .contains(coin)) {
                          ref
                              .read(addressBookFilterProvider)
                              .remove(coin, true);
                        } else {
                          ref.read(addressBookFilterProvider).add(coin, true);
                        }
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Checkbox(
                                  value: ref
                                      .watch(
                                        addressBookFilterProvider.select(
                                          (value) => value.coins,
                                        ),
                                      )
                                      .contains(coin),
                                  onChanged: (value) {
                                    if (value is bool) {
                                      if (value) {
                                        ref
                                            .read(addressBookFilterProvider)
                                            .add(coin, true);
                                      } else {
                                        ref
                                            .read(addressBookFilterProvider)
                                            .remove(coin, true);
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    coin.prettyName,
                                    style: STextStyles.largeMedium14(context),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    coin.ticker,
                                    style: STextStyles.itemSubtitle(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
