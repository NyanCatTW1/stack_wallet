/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:hive/hive.dart';

import '../../../services/exchange/change_now/change_now_exchange.dart';
import '../change_now/cn_exchange_transaction.dart';
import '../change_now/exchange_transaction.dart';

part 'trade.g.dart';

@HiveType(typeId: Trade.typeId)
class Trade {
  static const typeId = 22;

  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String tradeId;

  @HiveField(2)
  final String rateType;

  @HiveField(3)
  final String direction;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
  final String payInCurrency;

  @HiveField(7)
  final String payInAmount;

  @HiveField(8)
  final String payInAddress;

  @HiveField(9)
  final String payInNetwork;

  @HiveField(10)
  final String payInExtraId;

  @HiveField(11)
  final String payInTxid;

  @HiveField(12)
  final String payOutCurrency;

  @HiveField(13)
  final String payOutAmount;

  @HiveField(14)
  final String payOutAddress;

  @HiveField(15)
  final String payOutNetwork;

  @HiveField(16)
  final String payOutExtraId;

  @HiveField(17)
  final String payOutTxid;

  @HiveField(18)
  final String refundAddress;

  @HiveField(19)
  final String refundExtraId;

  @HiveField(20)
  final String status;

  @HiveField(21)
  final String exchangeName;

  const Trade({
    required this.uuid,
    required this.tradeId,
    required this.rateType,
    required this.direction,
    required this.timestamp,
    required this.updatedAt,
    required this.payInCurrency,
    required this.payInAmount,
    required this.payInAddress,
    required this.payInNetwork,
    required this.payInExtraId,
    required this.payInTxid,
    required this.payOutCurrency,
    required this.payOutAmount,
    required this.payOutAddress,
    required this.payOutNetwork,
    required this.payOutExtraId,
    required this.payOutTxid,
    required this.refundAddress,
    required this.refundExtraId,
    required this.status,
    required this.exchangeName,
  });

  Trade copyWith({
    String? tradeId,
    String? rateType,
    String? direction,
    DateTime? timestamp,
    DateTime? updatedAt,
    String? payInCurrency,
    String? payInAmount,
    String? payInAddress,
    String? payInNetwork,
    String? payInExtraId,
    String? payInTxid,
    String? payOutCurrency,
    String? payOutAmount,
    String? payOutAddress,
    String? payOutNetwork,
    String? payOutExtraId,
    String? payOutTxid,
    String? refundAddress,
    String? refundExtraId,
    String? status,
    String? exchangeName,
  }) {
    return Trade(
      uuid: uuid,
      tradeId: tradeId ?? this.tradeId,
      rateType: rateType ?? this.rateType,
      direction: direction ?? this.direction,
      timestamp: timestamp ?? this.timestamp,
      updatedAt: updatedAt ?? this.updatedAt,
      payInCurrency: payInCurrency ?? this.payInCurrency,
      payInAmount: payInAmount ?? this.payInAmount,
      payInAddress: payInAddress ?? this.payInAddress,
      payInNetwork: payInNetwork ?? this.payInNetwork,
      payInExtraId: payInExtraId ?? this.payInExtraId,
      payInTxid: payInTxid ?? this.payInTxid,
      payOutCurrency: payOutCurrency ?? this.payOutCurrency,
      payOutAmount: payOutAmount ?? this.payOutAmount,
      payOutAddress: payOutAddress ?? this.payOutAddress,
      payOutNetwork: payOutNetwork ?? this.payOutNetwork,
      payOutExtraId: payOutExtraId ?? this.payOutExtraId,
      payOutTxid: payOutTxid ?? this.payOutTxid,
      refundAddress: refundAddress ?? this.refundAddress,
      refundExtraId: refundExtraId ?? this.refundExtraId,
      status: status ?? this.status,
      exchangeName: exchangeName ?? this.exchangeName,
    );
  }

  Map<String, String> toMap() {
    return {
      "uuid": uuid,
      "tradeId": tradeId,
      "rateType": rateType,
      "direction": direction,
      "timestamp": timestamp.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "payInCurrency": payInCurrency,
      "payInAmount": payInAmount,
      "payInAddress": payInAddress,
      "payInNetwork": payInNetwork,
      "payInExtraId": payInExtraId,
      "payInTxid": payInTxid,
      "payOutCurrency": payOutCurrency,
      "payOutAmount": payOutAmount,
      "payOutAddress": payOutAddress,
      "payOutNetwork": payOutNetwork,
      "payOutExtraId": payOutExtraId,
      "payOutTxid": payOutTxid,
      "refundAddress": refundAddress,
      "refundExtraId": refundExtraId,
      "status": status,
      "exchangeName": exchangeName,
    };
  }

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      uuid: map["uuid"] as String,
      tradeId: map["tradeId"] as String,
      rateType: map["rateType"] as String,
      direction: map["direction"] as String,
      timestamp: DateTime.parse(map["timestamp"] as String),
      updatedAt: DateTime.parse(map["updatedAt"] as String),
      payInCurrency: map["payInCurrency"] as String,
      payInAmount: map["payInAmount"] as String,
      payInAddress: map["payInAddress"] as String,
      payInNetwork: map["payInNetwork"] as String,
      payInExtraId: map["payInExtraId"] as String,
      payInTxid: map["payInTxid"] as String,
      payOutCurrency: map["payOutCurrency"] as String,
      payOutAmount: map["payOutAmount"] as String,
      payOutAddress: map["payOutAddress"] as String,
      payOutNetwork: map["payOutNetwork"] as String,
      payOutExtraId: map["payOutExtraId"] as String,
      payOutTxid: map["payOutTxid"] as String,
      refundAddress: map["refundAddress"] as String,
      refundExtraId: map["refundExtraId"] as String,
      status: map["status"] as String,
      exchangeName: map["exchangeName"] as String,
    );
  }

  factory Trade.fromExchangeTransaction(
    ExchangeTransaction exTx,
    bool reversed,
  ) {
    return Trade(
      uuid: exTx.uuid,
      tradeId: exTx.id,
      rateType: "",
      direction: reversed ? "reverse" : "direct",
      timestamp: exTx.date,
      updatedAt: DateTime.tryParse(exTx.statusObject!.updatedAt) ?? exTx.date,
      payInCurrency: exTx.fromCurrency,
      payInAmount:
          exTx.statusObject!.amountSendDecimal.isEmpty
              ? exTx.statusObject!.expectedSendAmountDecimal
              : exTx.statusObject!.amountSendDecimal,
      payInAddress: exTx.payinAddress,
      payInNetwork: "",
      payInExtraId: exTx.payinExtraId,
      payInTxid: exTx.statusObject!.payinHash,
      payOutCurrency: exTx.toCurrency,
      payOutAmount: exTx.amount,
      payOutAddress: exTx.payoutAddress,
      payOutNetwork: "",
      payOutExtraId: exTx.payoutExtraId,
      payOutTxid: exTx.statusObject!.payoutHash,
      refundAddress: exTx.refundAddress,
      refundExtraId: exTx.refundExtraId,
      status: exTx.statusObject!.status.name,
      exchangeName: ChangeNowExchange.exchangeName,
    );
  }

  factory Trade.fromCNExchangeTransaction(
    CNExchangeTransaction exTx,
    bool reversed,
  ) {
    return Trade(
      uuid: exTx.uuid,
      tradeId: exTx.id,
      rateType: "",
      direction: reversed ? "reverse" : "direct",
      timestamp: exTx.date,
      updatedAt: DateTime.tryParse(exTx.statusObject!.updatedAt) ?? exTx.date,
      payInCurrency: exTx.fromCurrency,
      payInAmount:
          exTx.statusObject!.amountFrom ??
          exTx.statusObject!.expectedAmountFrom ??
          exTx.fromAmount.toString(),
      payInAddress: exTx.payinAddress,
      payInNetwork: exTx.fromNetwork,
      payInExtraId: "",
      payInTxid: exTx.statusObject!.payinHash ?? "",
      payOutCurrency: exTx.toCurrency,
      payOutAmount:
          exTx.statusObject!.amountTo ??
          exTx.statusObject!.expectedAmountTo ??
          exTx.toAmount.toString(),
      payOutAddress: exTx.payoutAddress,
      payOutNetwork: exTx.toNetwork,
      payOutExtraId: exTx.payoutExtraId,
      payOutTxid: exTx.statusObject!.payoutHash ?? "",
      refundAddress: exTx.refundAddress,
      refundExtraId: exTx.refundExtraId,
      status: exTx.statusObject!.status.name,
      exchangeName: ChangeNowExchange.exchangeName,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
