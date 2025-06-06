/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2025 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2025-04-26
 *
 */

import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

import 'cn_exchange_transaction_status.dart';

class CNExchangeTransaction {
  /// The amount being sent from the user.
  final Decimal fromAmount;

  /// The amount the user will receive.
  final Decimal toAmount;

  /// The type of exchange flow. Either "standard" or "fixed-rate".
  final String flow;

  /// Direction of the exchange: "direct" or "reverse".
  final String type;

  /// The address to which the user sends the input currency.
  final String payinAddress;

  /// The address where the exchanged currency will be sent.
  final String payoutAddress;

  /// Extra ID for payout address (e.g., memo, tag). Empty string if not used.
  final String payoutExtraId;

  /// Currency ticker being exchanged from (e.g., "btc").
  final String fromCurrency;

  /// Currency ticker being exchanged to (e.g., "xmr").
  final String toCurrency;

  /// Refund address in case of failure or timeout.
  final String refundAddress;

  /// Extra ID for the refund address (if needed). Empty string if not used.
  final String refundExtraId;

  /// Deadline until which the estimated rate or transaction is valid.
  final DateTime validUntil;

  /// Date when transaction was created.
  final DateTime date;

  /// Unique transaction identifier.
  final String id;

  /// The user-defined or system-determined amount in a "directed" flow.
  final Decimal? directedAmount;

  /// Network of the currency being sent.
  final String fromNetwork;

  /// Network of the currency being received.
  final String toNetwork;

  final String uuid;

  final CNExchangeTransactionStatus? statusObject;

  const CNExchangeTransaction({
    required this.fromAmount,
    required this.toAmount,
    required this.flow,
    required this.type,
    required this.payinAddress,
    required this.payoutAddress,
    required this.payoutExtraId,
    required this.fromCurrency,
    required this.toCurrency,
    required this.refundAddress,
    required this.refundExtraId,
    required this.validUntil,
    required this.date,
    required this.id,
    required this.directedAmount,
    required this.fromNetwork,
    required this.toNetwork,
    required this.uuid,
    this.statusObject,
  });

  factory CNExchangeTransaction.fromJson(Map<String, dynamic> json) {
    return CNExchangeTransaction(
      fromAmount: Decimal.parse(json["fromAmount"].toString()),
      toAmount: Decimal.parse(json["toAmount"].toString()),
      flow: json["flow"] as String,
      type: json["type"] as String,
      payinAddress: json["payinAddress"] as String,
      payoutAddress: json["payoutAddress"] as String,
      payoutExtraId: json["payoutExtraId"] as String? ?? "",
      fromCurrency: json["fromCurrency"] as String,
      toCurrency: json["toCurrency"] as String,
      refundAddress: json["refundAddress"] as String,
      refundExtraId: json["refundExtraId"] as String,
      validUntil: DateTime.parse(json["validUntil"] as String),
      date: DateTime.parse(json["date"] as String),
      id: json["id"] as String,
      directedAmount: Decimal.tryParse(json["directedAmount"].toString()),
      fromNetwork: json["fromNetwork"] as String? ?? "",
      toNetwork: json["toNetwork"] as String? ?? "",
      uuid: json["uuid"] as String? ?? const Uuid().v1(),
      statusObject:
          json["statusObject"] is Map<String, dynamic>
              ? CNExchangeTransactionStatus.fromMap(
                json["statusObject"] as Map<String, dynamic>,
              )
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fromAmount": fromAmount,
      "toAmount": toAmount,
      "flow": flow,
      "type": type,
      "payinAddress": payinAddress,
      "payoutAddress": payoutAddress,
      "payoutExtraId": payoutExtraId,
      "fromCurrency": fromCurrency,
      "toCurrency": toCurrency,
      "refundAddress": refundAddress,
      "refundExtraId": refundExtraId,
      "validUntil": validUntil.toIso8601String(),
      "date": date.toIso8601String(),
      "id": id,
      "directedAmount": directedAmount,
      "fromNetwork": fromNetwork,
      "uuid": uuid,
      "statusObject": statusObject?.toMap(),
    };
  }

  CNExchangeTransaction copyWithStatus(CNExchangeTransactionStatus? status) {
    return CNExchangeTransaction(
      fromAmount: fromAmount,
      toAmount: toAmount,
      flow: flow,
      type: type,
      payinAddress: payinAddress,
      payoutAddress: payoutAddress,
      payoutExtraId: payoutExtraId,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      refundAddress: refundAddress,
      refundExtraId: refundExtraId,
      validUntil: validUntil,
      date: date,
      id: id,
      directedAmount: directedAmount,
      fromNetwork: fromNetwork,
      toNetwork: toNetwork,
      uuid: uuid,
      statusObject: status,
    );
  }

  @override
  String toString() {
    return "CNExchangeTransaction: ${toMap()}";
  }
}
