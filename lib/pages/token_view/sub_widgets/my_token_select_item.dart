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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/isar/models/ethereum/eth_contract.dart';
import '../../../pages_desktop_specific/my_stack_view/wallet_view/desktop_token_view.dart';
import '../../../providers/db/main_db_provider.dart';
import '../../../providers/providers.dart';
import '../../../services/ethereum/cached_eth_token_balance.dart';
import '../../../themes/stack_colors.dart';
import '../../../utilities/amount/amount_formatter.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/show_loading.dart';
import '../../../utilities/text_styles.dart';
import '../../../utilities/util.dart';
import '../../../wallets/crypto_currency/crypto_currency.dart';
import '../../../wallets/isar/providers/eth/current_token_wallet_provider.dart';
import '../../../wallets/isar/providers/eth/token_balance_provider.dart';
import '../../../wallets/isar/providers/wallet_info_provider.dart';
import '../../../wallets/wallet/impl/ethereum_wallet.dart';
import '../../../wallets/wallet/impl/sub_wallets/eth_token_wallet.dart';
import '../../../wallets/wallet/wallet.dart';
import '../../../widgets/desktop/primary_button.dart';
import '../../../widgets/dialogs/basic_dialog.dart';
import '../../../widgets/icon_widgets/eth_token_icon.dart';
import '../../../widgets/rounded_white_container.dart';
import '../token_view.dart';

class MyTokenSelectItem extends ConsumerStatefulWidget {
  const MyTokenSelectItem({
    super.key,
    required this.walletId,
    required this.token,
  });

  final String walletId;
  final EthContract token;

  @override
  ConsumerState<MyTokenSelectItem> createState() => _MyTokenSelectItemState();
}

class _MyTokenSelectItemState extends ConsumerState<MyTokenSelectItem> {
  final bool isDesktop = Util.isDesktop;

  late final CachedEthTokenBalance cachedBalance;

  Future<bool> _loadTokenWallet(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(pCurrentTokenWallet)!.init();
      return true;
    } catch (_) {
      await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => BasicDialog(
              title: "Failed to load token data",
              desktopHeight: double.infinity,
              desktopWidth: 450,
              rightButton: PrimaryButton(
                label: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                  if (!isDesktop) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
      );
      return false;
    }
  }

  void _onPressed() async {
    final old = ref.read(tokenServiceStateProvider);
    // exit previous if there is one
    unawaited(old?.exit());
    ref.read(tokenServiceStateProvider.state).state =
        Wallet.loadTokenWallet(
              ethWallet:
                  ref.read(pWallets).getWallet(widget.walletId)
                      as EthereumWallet,
              contract: widget.token,
            )
            as EthTokenWallet;

    final success = await showLoading<bool>(
      whileFuture: _loadTokenWallet(context, ref),
      context: context,
      rootNavigator: isDesktop,
      message: "Loading ${widget.token.name}",
    );

    if (!success!) {
      return;
    }

    if (mounted) {
      unawaited(ref.read(pCurrentTokenWallet)!.refresh());
      await Navigator.of(context).pushNamed(
        isDesktop ? DesktopTokenView.routeName : TokenView.routeName,
        arguments: widget.walletId,
      );
    }
  }

  @override
  void initState() {
    cachedBalance = CachedEthTokenBalance(widget.walletId, widget.token);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final address = ref.read(pWalletReceivingAddress(widget.walletId));
        await cachedBalance.fetchAndUpdateCachedBalance(
          address,
          ref.read(mainDBProvider),
        );
        if (mounted) {
          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? priceString;
    if (ref.watch(prefsChangeNotifierProvider.select((s) => s.externalCalls))) {
      priceString = ref.watch(
        priceAnd24hChangeNotifierProvider.select(
          (s) =>
              s.getTokenPrice(widget.token.address)?.value.toStringAsFixed(2),
        ),
      );
    }

    return RoundedWhiteContainer(
      padding: const EdgeInsets.all(0),
      child: MaterialButton(
        key: Key("walletListItemButtonKey_${widget.token.symbol}"),
        padding:
            isDesktop
                ? const EdgeInsets.symmetric(horizontal: 28, vertical: 24)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Constants.size.circularBorderRadius,
          ),
        ),
        onPressed: _onPressed,
        child: Row(
          children: [
            EthTokenIcon(
              contractAddress: widget.token.address,
              size: isDesktop ? 32 : 28,
            ),
            SizedBox(width: isDesktop ? 12 : 10),
            Expanded(
              child: Consumer(
                builder: (_, ref, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.token.name,
                            style:
                                isDesktop
                                    ? STextStyles.desktopTextExtraSmall(
                                      context,
                                    ).copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).extension<StackColors>()!.textDark,
                                    )
                                    : STextStyles.titleBold12(context),
                          ),
                          const Spacer(),
                          Text(
                            ref
                                .watch(
                                  pAmountFormatter(
                                    Ethereum(CryptoCurrencyNetwork.main),
                                  ),
                                )
                                .format(
                                  ref
                                      .watch(
                                        pTokenBalance((
                                          walletId: widget.walletId,
                                          contractAddress: widget.token.address,
                                        )),
                                      )
                                      .total,
                                  ethContract: widget.token,
                                ),
                            style:
                                isDesktop
                                    ? STextStyles.desktopTextExtraSmall(
                                      context,
                                    ).copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).extension<StackColors>()!.textDark,
                                    )
                                    : STextStyles.itemSubtitle(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            widget.token.symbol,
                            style:
                                isDesktop
                                    ? STextStyles.desktopTextExtraExtraSmall(
                                      context,
                                    )
                                    : STextStyles.itemSubtitle(context),
                          ),
                          const Spacer(),
                          if (priceString != null)
                            Text(
                              "$priceString "
                              "${ref.watch(prefsChangeNotifierProvider.select((value) => value.currency))}",
                              style:
                                  isDesktop
                                      ? STextStyles.desktopTextExtraExtraSmall(
                                        context,
                                      )
                                      : STextStyles.itemSubtitle(context),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
