/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:cs_monero/cs_monero.dart' as lib_monero;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/paymint/fee_object_model.dart';
import '../../../providers/providers.dart';
import '../../../providers/ui/fee_rate_type_state_provider.dart';
import '../../../providers/wallet/public_private_balance_state_provider.dart';
import '../../../themes/stack_colors.dart';
import '../../../utilities/amount/amount.dart';
import '../../../utilities/amount/amount_formatter.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/enums/fee_rate_type_enum.dart';
import '../../../utilities/logger.dart';
import '../../../utilities/text_styles.dart';
import '../../../wallets/crypto_currency/crypto_currency.dart';
import '../../../wallets/isar/providers/eth/current_token_wallet_provider.dart';
import '../../../wallets/isar/providers/wallet_info_provider.dart';
import '../../../wallets/wallet/impl/firo_wallet.dart';
import '../../../wallets/wallet/wallet_mixin_interfaces/electrumx_interface.dart';
import '../../../widgets/animated_text.dart';

final feeSheetSessionCacheProvider =
    ChangeNotifierProvider<FeeSheetSessionCache>((ref) {
      return FeeSheetSessionCache();
    });

class FeeSheetSessionCache extends ChangeNotifier {
  final Map<Amount, Amount> fast = {};
  final Map<Amount, Amount> average = {};
  final Map<Amount, Amount> slow = {};

  void notify() => notifyListeners();
}

class TransactionFeeSelectionSheet extends ConsumerStatefulWidget {
  const TransactionFeeSelectionSheet({
    super.key,
    required this.walletId,
    required this.amount,
    required this.updateChosen,
    this.isToken = false,
  });

  final String walletId;
  final Amount amount;
  final Function updateChosen;
  final bool isToken;

  @override
  ConsumerState<TransactionFeeSelectionSheet> createState() =>
      _TransactionFeeSelectionSheetState();
}

class _TransactionFeeSelectionSheetState
    extends ConsumerState<TransactionFeeSelectionSheet> {
  late final String walletId;
  late final Amount amount;

  FeeObject? feeObject;

  final stringsToLoopThrough = [
    "Calculating",
    "Calculating.",
    "Calculating..",
    "Calculating...",
  ];

  Future<Amount> feeFor({
    required Amount amount,
    required FeeRateType feeRateType,
    required BigInt feeRate,
    required CryptoCurrency coin,
  }) async {
    switch (feeRateType) {
      case FeeRateType.fast:
        if (ref.read(feeSheetSessionCacheProvider).fast[amount] == null) {
          if (widget.isToken == false) {
            final wallet = ref.read(pWallets).getWallet(walletId);

            if (coin is Monero || coin is Wownero) {
              final fee = await wallet.estimateFeeFor(
                amount,
                BigInt.from(lib_monero.TransactionPriority.high.value),
              );
              ref.read(feeSheetSessionCacheProvider).fast[amount] = fee;
            } else if (coin is Firo) {
              final Amount fee;
              switch (ref.read(publicPrivateBalanceStateProvider.state).state) {
                case FiroType.spark:
                  fee = await (wallet as FiroWallet).estimateFeeForSpark(
                    amount,
                  );
                case FiroType.lelantus:
                  fee = await (wallet as FiroWallet).estimateFeeForLelantus(
                    amount,
                  );
                case FiroType.public:
                  fee = await (wallet as FiroWallet).estimateFeeFor(
                    amount,
                    feeRate,
                  );
              }

              ref.read(feeSheetSessionCacheProvider).fast[amount] = fee;
            } else {
              ref.read(feeSheetSessionCacheProvider).fast[amount] = await wallet
                  .estimateFeeFor(amount, feeRate);
            }
          } else {
            final tokenWallet = ref.read(pCurrentTokenWallet)!;
            final fee = await tokenWallet.estimateFeeFor(amount, feeRate);
            ref.read(feeSheetSessionCacheProvider).fast[amount] = fee;
          }
        }
        return ref.read(feeSheetSessionCacheProvider).fast[amount]!;

      case FeeRateType.average:
        if (ref.read(feeSheetSessionCacheProvider).average[amount] == null) {
          if (widget.isToken == false) {
            final wallet = ref.read(pWallets).getWallet(walletId);
            if (coin is Monero || coin is Wownero) {
              final fee = await wallet.estimateFeeFor(
                amount,
                BigInt.from(lib_monero.TransactionPriority.medium.value),
              );
              ref.read(feeSheetSessionCacheProvider).average[amount] = fee;
            } else if (coin is Firo) {
              final Amount fee;
              switch (ref.read(publicPrivateBalanceStateProvider.state).state) {
                case FiroType.spark:
                  fee = await (wallet as FiroWallet).estimateFeeForSpark(
                    amount,
                  );
                case FiroType.lelantus:
                  fee = await (wallet as FiroWallet).estimateFeeForLelantus(
                    amount,
                  );
                case FiroType.public:
                  fee = await (wallet as FiroWallet).estimateFeeFor(
                    amount,
                    feeRate,
                  );
              }
              ref.read(feeSheetSessionCacheProvider).average[amount] = fee;
            } else {
              ref.read(feeSheetSessionCacheProvider).average[amount] =
                  await wallet.estimateFeeFor(amount, feeRate);
            }
          } else {
            final tokenWallet = ref.read(pCurrentTokenWallet)!;
            final fee = await tokenWallet.estimateFeeFor(amount, feeRate);
            ref.read(feeSheetSessionCacheProvider).average[amount] = fee;
          }
        }
        return ref.read(feeSheetSessionCacheProvider).average[amount]!;

      case FeeRateType.slow:
        if (ref.read(feeSheetSessionCacheProvider).slow[amount] == null) {
          if (widget.isToken == false) {
            final wallet = ref.read(pWallets).getWallet(walletId);
            if (coin is Monero || coin is Wownero) {
              final fee = await wallet.estimateFeeFor(
                amount,
                BigInt.from(lib_monero.TransactionPriority.normal.value),
              );
              ref.read(feeSheetSessionCacheProvider).slow[amount] = fee;
            } else if (coin is Firo) {
              final Amount fee;
              switch (ref.read(publicPrivateBalanceStateProvider.state).state) {
                case FiroType.spark:
                  fee = await (wallet as FiroWallet).estimateFeeForSpark(
                    amount,
                  );
                case FiroType.lelantus:
                  fee = await (wallet as FiroWallet).estimateFeeForLelantus(
                    amount,
                  );
                case FiroType.public:
                  fee = await (wallet as FiroWallet).estimateFeeFor(
                    amount,
                    feeRate,
                  );
              }
              ref.read(feeSheetSessionCacheProvider).slow[amount] = fee;
            } else {
              ref.read(feeSheetSessionCacheProvider).slow[amount] = await wallet
                  .estimateFeeFor(amount, feeRate);
            }
          } else {
            final tokenWallet = ref.read(pCurrentTokenWallet)!;
            final fee = await tokenWallet.estimateFeeFor(amount, feeRate);
            ref.read(feeSheetSessionCacheProvider).slow[amount] = fee;
          }
        }
        return ref.read(feeSheetSessionCacheProvider).slow[amount]!;

      default:
        return Amount.zero;
    }
  }

  String estimatedTimeToBeIncludedInNextBlock(
    int targetBlockTime,
    int estimatedNumberOfBlocks,
  ) {
    final int time = targetBlockTime * estimatedNumberOfBlocks;

    final int hours = (time / 3600).floor();
    if (hours > 1) {
      return "~$hours hours";
    } else if (hours == 1) {
      return "~$hours hour";
    }

    // less than an hour

    final string = (time / 60).toStringAsFixed(1);

    if (string == "1.0") {
      return "~1 minute";
    } else {
      if (string.endsWith(".0")) {
        return "~${(time / 60).floor()} minutes";
      }
      return "~$string minutes";
    }
  }

  @override
  void initState() {
    walletId = widget.walletId;
    amount = widget.amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    final wallet = ref.watch(pWallets).getWallet(walletId);

    final coin = ref.watch(pWalletCoin(walletId));

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<StackColors>()!.popupBG,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(
                        context,
                      ).extension<StackColors>()!.textFieldDefaultBG,
                  borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius,
                  ),
                ),
                width: 60,
                height: 4,
              ),
            ),
            const SizedBox(height: 36),
            FutureBuilder(
              future:
                  widget.isToken
                      ? ref.read(pCurrentTokenWallet)!.fees
                      : wallet.fees,
              builder: (context, AsyncSnapshot<FeeObject> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  feeObject = snapshot.data!;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fee rate",
                      style: STextStyles.pageTitleH2(context),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        final state =
                            ref
                                .read(feeRateTypeMobileStateProvider.state)
                                .state;
                        if (state != FeeRateType.fast) {
                          ref.read(feeRateTypeMobileStateProvider.state).state =
                              FeeRateType.fast;
                        }
                        final String? fee = getAmount(
                          FeeRateType.fast,
                          wallet.info.coin,
                        );
                        if (fee != null) {
                          widget.updateChosen(fee);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Radio(
                                    activeColor:
                                        Theme.of(context)
                                            .extension<StackColors>()!
                                            .radioButtonIconEnabled,
                                    value: FeeRateType.fast,
                                    groupValue:
                                        ref
                                            .watch(
                                              feeRateTypeMobileStateProvider
                                                  .state,
                                            )
                                            .state,
                                    onChanged: (x) {
                                      ref
                                          .read(
                                            feeRateTypeMobileStateProvider
                                                .state,
                                          )
                                          .state = FeeRateType.fast;

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        FeeRateType.fast.prettyName,
                                        style: STextStyles.titleBold12(context),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 2),
                                      if (feeObject == null)
                                        AnimatedText(
                                          stringsToLoopThrough:
                                              stringsToLoopThrough,
                                          style: STextStyles.itemSubtitle(
                                            context,
                                          ),
                                        ),
                                      if (feeObject != null)
                                        FutureBuilder(
                                          future: feeFor(
                                            coin: coin,
                                            feeRateType: FeeRateType.fast,
                                            feeRate: feeObject!.fast,
                                            amount: amount,
                                          ),
                                          builder: (
                                            _,
                                            AsyncSnapshot<Amount> snapshot,
                                          ) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              return Text(
                                                "(~${ref.watch(pAmountFormatter(coin)).format(snapshot.data!, indicatePrecisionLoss: false)})",
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                                textAlign: TextAlign.left,
                                              );
                                            } else {
                                              return AnimatedText(
                                                stringsToLoopThrough:
                                                    stringsToLoopThrough,
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  if (feeObject == null && coin is! Ethereum)
                                    AnimatedText(
                                      stringsToLoopThrough:
                                          stringsToLoopThrough,
                                      style: STextStyles.itemSubtitle(context),
                                    ),
                                  if (feeObject != null && coin is! Ethereum)
                                    Text(
                                      estimatedTimeToBeIncludedInNextBlock(
                                        coin.targetBlockTimeSeconds,
                                        feeObject!.numberOfBlocksFast,
                                      ),
                                      style: STextStyles.itemSubtitle(context),
                                      textAlign: TextAlign.left,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        final state =
                            ref
                                .read(feeRateTypeMobileStateProvider.state)
                                .state;
                        if (state != FeeRateType.average) {
                          ref.read(feeRateTypeMobileStateProvider.state).state =
                              FeeRateType.average;
                        }
                        final String? fee = getAmount(
                          FeeRateType.average,
                          coin,
                        );
                        if (fee != null) {
                          widget.updateChosen(fee);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Radio(
                                    activeColor:
                                        Theme.of(context)
                                            .extension<StackColors>()!
                                            .radioButtonIconEnabled,
                                    value: FeeRateType.average,
                                    groupValue:
                                        ref
                                            .watch(
                                              feeRateTypeMobileStateProvider
                                                  .state,
                                            )
                                            .state,
                                    onChanged: (x) {
                                      ref
                                          .read(
                                            feeRateTypeMobileStateProvider
                                                .state,
                                          )
                                          .state = FeeRateType.average;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        FeeRateType.average.prettyName,
                                        style: STextStyles.titleBold12(context),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 2),
                                      if (feeObject == null)
                                        AnimatedText(
                                          stringsToLoopThrough:
                                              stringsToLoopThrough,
                                          style: STextStyles.itemSubtitle(
                                            context,
                                          ),
                                        ),
                                      if (feeObject != null)
                                        FutureBuilder(
                                          future: feeFor(
                                            coin: coin,
                                            feeRateType: FeeRateType.average,
                                            feeRate: feeObject!.medium,
                                            amount: amount,
                                          ),
                                          builder: (
                                            _,
                                            AsyncSnapshot<Amount> snapshot,
                                          ) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              return Text(
                                                "(~${ref.watch(pAmountFormatter(coin)).format(snapshot.data!, indicatePrecisionLoss: false)})",
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                                textAlign: TextAlign.left,
                                              );
                                            } else {
                                              return AnimatedText(
                                                stringsToLoopThrough:
                                                    stringsToLoopThrough,
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  if (feeObject == null && coin is! Ethereum)
                                    AnimatedText(
                                      stringsToLoopThrough:
                                          stringsToLoopThrough,
                                      style: STextStyles.itemSubtitle(context),
                                    ),
                                  if (feeObject != null && coin is! Ethereum)
                                    Text(
                                      estimatedTimeToBeIncludedInNextBlock(
                                        coin.targetBlockTimeSeconds,
                                        feeObject!.numberOfBlocksAverage,
                                      ),
                                      style: STextStyles.itemSubtitle(context),
                                      textAlign: TextAlign.left,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        final state =
                            ref
                                .read(feeRateTypeMobileStateProvider.state)
                                .state;
                        if (state != FeeRateType.slow) {
                          ref.read(feeRateTypeMobileStateProvider.state).state =
                              FeeRateType.slow;
                        }
                        final String? fee = getAmount(FeeRateType.slow, coin);
                        if (fee != null) {
                          widget.updateChosen(fee);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Radio(
                                    activeColor:
                                        Theme.of(context)
                                            .extension<StackColors>()!
                                            .radioButtonIconEnabled,
                                    value: FeeRateType.slow,
                                    groupValue:
                                        ref
                                            .watch(
                                              feeRateTypeMobileStateProvider
                                                  .state,
                                            )
                                            .state,
                                    onChanged: (x) {
                                      ref
                                          .read(
                                            feeRateTypeMobileStateProvider
                                                .state,
                                          )
                                          .state = FeeRateType.slow;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        FeeRateType.slow.prettyName,
                                        style: STextStyles.titleBold12(context),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 2),
                                      if (feeObject == null)
                                        AnimatedText(
                                          stringsToLoopThrough:
                                              stringsToLoopThrough,
                                          style: STextStyles.itemSubtitle(
                                            context,
                                          ),
                                        ),
                                      if (feeObject != null)
                                        FutureBuilder(
                                          future: feeFor(
                                            coin: coin,
                                            feeRateType: FeeRateType.slow,
                                            feeRate: feeObject!.slow,
                                            amount: amount,
                                          ),
                                          builder: (
                                            _,
                                            AsyncSnapshot<Amount> snapshot,
                                          ) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              return Text(
                                                "(~${ref.watch(pAmountFormatter(coin)).format(snapshot.data!, indicatePrecisionLoss: false)})",
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                                textAlign: TextAlign.left,
                                              );
                                            } else {
                                              return AnimatedText(
                                                stringsToLoopThrough:
                                                    stringsToLoopThrough,
                                                style: STextStyles.itemSubtitle(
                                                  context,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  if (feeObject == null && coin is! Ethereum)
                                    AnimatedText(
                                      stringsToLoopThrough:
                                          stringsToLoopThrough,
                                      style: STextStyles.itemSubtitle(context),
                                    ),
                                  if (feeObject != null && coin is! Ethereum)
                                    Text(
                                      estimatedTimeToBeIncludedInNextBlock(
                                        coin.targetBlockTimeSeconds,
                                        feeObject!.numberOfBlocksSlow,
                                      ),
                                      style: STextStyles.itemSubtitle(context),
                                      textAlign: TextAlign.left,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (wallet is ElectrumXInterface || coin is Ethereum)
                      GestureDetector(
                        onTap: () {
                          final state =
                              ref
                                  .read(feeRateTypeMobileStateProvider.state)
                                  .state;
                          if (state != FeeRateType.custom) {
                            ref
                                .read(feeRateTypeMobileStateProvider.state)
                                .state = FeeRateType.custom;
                          }
                          widget.updateChosen("custom");

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Radio(
                                      activeColor:
                                          Theme.of(context)
                                              .extension<StackColors>()!
                                              .radioButtonIconEnabled,
                                      value: FeeRateType.custom,
                                      groupValue:
                                          ref
                                              .watch(
                                                feeRateTypeMobileStateProvider
                                                    .state,
                                              )
                                              .state,
                                      onChanged: (x) {
                                        ref
                                            .read(
                                              feeRateTypeMobileStateProvider
                                                  .state,
                                            )
                                            .state = FeeRateType.custom;
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          FeeRateType.custom.prettyName,
                                          style: STextStyles.titleBold12(
                                            context,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (wallet is ElectrumXInterface || coin is Ethereum)
                      const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String? getAmount(FeeRateType feeRateType, CryptoCurrency coin) {
    try {
      switch (feeRateType) {
        case FeeRateType.fast:
          if (ref.read(feeSheetSessionCacheProvider).fast[amount] != null) {
            return ref
                .read(pAmountFormatter(coin))
                .format(
                  ref.read(feeSheetSessionCacheProvider).fast[amount]!,
                  indicatePrecisionLoss: false,
                  withUnitName: false,
                );
          }
          return null;

        case FeeRateType.average:
          if (ref.read(feeSheetSessionCacheProvider).average[amount] != null) {
            return ref
                .read(pAmountFormatter(coin))
                .format(
                  ref.read(feeSheetSessionCacheProvider).average[amount]!,
                  indicatePrecisionLoss: false,
                  withUnitName: false,
                );
          }
          return null;

        case FeeRateType.slow:
          if (ref.read(feeSheetSessionCacheProvider).slow[amount] != null) {
            return ref
                .read(pAmountFormatter(coin))
                .format(
                  ref.read(feeSheetSessionCacheProvider).slow[amount]!,
                  indicatePrecisionLoss: false,
                  withUnitName: false,
                );
          }
          return null;
        case FeeRateType.custom:
          return null;
      }
    } catch (e, s) {
      Logging.instance.w("$e $s", error: e, stackTrace: s);
      return null;
    }
  }
}
