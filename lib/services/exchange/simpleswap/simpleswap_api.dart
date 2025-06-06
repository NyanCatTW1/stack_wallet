/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

import '../../../exceptions/exchange/exchange_exception.dart';
import '../../../external_api_keys.dart';
import '../../../models/exchange/response_objects/fixed_rate_market.dart';
import '../../../models/exchange/response_objects/range.dart';
import '../../../models/exchange/response_objects/trade.dart';
import '../../../models/exchange/simpleswap/sp_currency.dart';
import '../../../models/isar/exchange_cache/pair.dart';
import '../../../networking/http.dart';
import '../../../utilities/logger.dart';
import '../../../utilities/prefs.dart';
import '../../tor_service.dart';
import '../exchange_response.dart';
import 'simpleswap_exchange.dart';

class SimpleSwapAPI {
  static const String scheme = "https";
  static const String authority = "api.simpleswap.io";

  SimpleSwapAPI._();
  static final SimpleSwapAPI _instance = SimpleSwapAPI._();
  static SimpleSwapAPI get instance => _instance;

  HTTP client = HTTP();

  Uri _buildUri(String path, Map<String, String>? params) {
    return Uri.https(authority, path, params);
  }

  Future<dynamic> _makeGetRequest(Uri uri) async {
    int code = -1;
    try {
      final response = await client.get(
        url: uri,
        proxyInfo: Prefs.instance.useTor
            ? TorService.sharedInstance.getProxyInfo()
            : null,
      );

      code = response.code;

      final parsed = jsonDecode(response.body);

      return parsed;
    } catch (e, s) {
      Logging.instance
          .e("_makeRequest($uri) HTTP:$code threw: ", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<dynamic> _makePostRequest(
    Uri uri,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await client.post(
        url: uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
        proxyInfo: Prefs.instance.useTor
            ? TorService.sharedInstance.getProxyInfo()
            : null,
      );

      if (response.code == 200) {
        final parsed = jsonDecode(response.body);
        return parsed;
      }

      throw Exception("response: ${response.body}");
    } catch (e, s) {
      Logging.instance.e(
        "_makeRequest($uri) threw",
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  Future<ExchangeResponse<Trade>> createNewExchange({
    required bool isFixedRate,
    required String currencyFrom,
    required String currencyTo,
    required String addressTo,
    required String userRefundAddress,
    required String userRefundExtraId,
    required String amount,
    String? extraIdTo,
    String? apiKey,
  }) async {
    final Map<String, dynamic> body = {
      "fixed": isFixedRate,
      "currency_from": currencyFrom,
      "currency_to": currencyTo,
      "addressTo": addressTo,
      "userRefundAddress": userRefundAddress,
      "userRefundExtraId": userRefundExtraId,
      "amount": double.parse(amount),
      "extraIdTo": extraIdTo,
    };

    final uri =
        _buildUri("/create_exchange", {"api_key": apiKey ?? kSimpleSwapApiKey});

    try {
      final jsonObject = await _makePostRequest(uri, body);

      final json = Map<String, dynamic>.from(jsonObject as Map);
      final trade = Trade(
        uuid: const Uuid().v1(),
        tradeId: json["id"] as String,
        rateType: json["type"] as String,
        direction: "direct",
        timestamp: DateTime.parse(json["timestamp"] as String),
        updatedAt: DateTime.parse(json["updated_at"] as String),
        payInCurrency: json["currency_from"] as String,
        payInAmount: json["amount_from"] as String,
        payInAddress: json["address_from"] as String,
        payInNetwork: "",
        payInExtraId: json["extra_id_from"] as String? ?? "",
        payInTxid: json["tx_from"] as String? ?? "",
        payOutCurrency: json["currency_to"] as String,
        payOutAmount: json["amount_to"] as String,
        payOutAddress: json["address_to"] as String,
        payOutNetwork: "",
        payOutExtraId: json["extra_id_to"] as String? ?? "",
        payOutTxid: json["tx_to"] as String? ?? "",
        refundAddress: json["user_refund_address"] as String,
        refundExtraId: json["user_refund_extra_id"] as String,
        status: json["status"] as String,
        exchangeName: SimpleSwapExchange.exchangeName,
      );
      return ExchangeResponse(value: trade, exception: null);
    } catch (e, s) {
      Logging.instance
          .e("getAvailableCurrencies exception: ", error: e, stackTrace: s);
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
        value: null,
      );
    }
  }

  Future<ExchangeResponse<List<SPCurrency>>> getAllCurrencies({
    String? apiKey,
    required bool fixedRate,
  }) async {
    final uri = _buildUri(
      "/get_all_currencies",
      {"api_key": apiKey ?? kSimpleSwapApiKey},
    );

    try {
      final jsonArray = await _makeGetRequest(uri);

      return await compute(_parseAvailableCurrenciesJson, jsonArray as List);
    } catch (e, s) {
      Logging.instance
          .e("getAvailableCurrencies exception: ", error: e, stackTrace: s);
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  ExchangeResponse<List<SPCurrency>> _parseAvailableCurrenciesJson(
    List<dynamic> jsonArray,
  ) {
    try {
      final List<SPCurrency> currencies = [];

      for (final json in jsonArray) {
        try {
          currencies
              .add(SPCurrency.fromJson(Map<String, dynamic>.from(json as Map)));
        } catch (_) {
          return ExchangeResponse(
            exception: ExchangeException(
              "Failed to serialize $json",
              ExchangeExceptionType.serializeResponseError,
            ),
          );
        }
      }

      return ExchangeResponse(value: currencies);
    } catch (e, s) {
      Logging.instance.e(
        "_parseAvailableCurrenciesJson exception: ",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  Future<ExchangeResponse<SPCurrency>> getCurrency({
    required String symbol,
    String? apiKey,
  }) async {
    final uri = _buildUri(
      "/get_currency",
      {
        "api_key": apiKey ?? kSimpleSwapApiKey,
        "symbol": symbol,
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);

      return ExchangeResponse(
        value: SPCurrency.fromJson(
          Map<String, dynamic>.from(jsonObject as Map),
        ),
      );
    } catch (e, s) {
      Logging.instance.e(
        "getCurrency exception",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  /// returns a map where the key currency symbol is a valid pair with any of
  /// the symbols in its value list
  Future<ExchangeResponse<List<Pair>>> getAllPairs({
    required bool isFixedRate,
    String? apiKey,
  }) async {
    final uri = _buildUri(
      "/get_all_pairs",
      {
        "api_key": apiKey ?? kSimpleSwapApiKey,
        "fixed": isFixedRate.toString(),
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);
      final result = await compute(
        _parseAvailablePairsJson,
        Tuple2(jsonObject as Map, isFixedRate),
      );
      return result;
    } catch (e, s) {
      Logging.instance.e(
        "getAllPairs exception",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  ExchangeResponse<List<Pair>> _parseAvailablePairsJson(
    Tuple2<Map<dynamic, dynamic>, bool> args,
  ) {
    try {
      final List<Pair> pairs = [];

      for (final entry in args.item1.entries) {
        try {
          final from = entry.key as String;
          for (final to in entry.value as List) {
            pairs.add(
              Pair(
                exchangeName: SimpleSwapExchange.exchangeName,
                from: from,
                to: to as String,
                rateType: SupportedRateType.estimated,
              ),
            );
          }
        } catch (_) {
          return ExchangeResponse(
            exception: ExchangeException(
              "Failed to serialize $json",
              ExchangeExceptionType.serializeResponseError,
            ),
          );
        }
      }

      return ExchangeResponse(value: pairs);
    } catch (e, s) {
      Logging.instance.e(
        "_parseAvailableCurrenciesJson exception: ",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  /// returns the estimated amount as a string
  Future<ExchangeResponse<String>> getEstimated({
    required bool isFixedRate,
    required String currencyFrom,
    required String currencyTo,
    required String amount,
    String? apiKey,
  }) async {
    final uri = _buildUri(
      "/get_estimated",
      {
        "api_key": apiKey ?? kSimpleSwapApiKey,
        "fixed": isFixedRate.toString(),
        "currency_from": currencyFrom,
        "currency_to": currencyTo,
        "amount": amount,
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);

      return ExchangeResponse(value: jsonObject as String);
    } catch (e, s) {
      Logging.instance.e(
        "getEstimated exception",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  /// returns the exchange for the given id
  Future<ExchangeResponse<Trade>> getExchange({
    required String exchangeId,
    String? apiKey,
    Trade? oldTrade,
  }) async {
    final uri = _buildUri(
      "/get_exchange",
      {
        "api_key": apiKey ?? kSimpleSwapApiKey,
        "id": exchangeId,
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);

      final json = Map<String, dynamic>.from(jsonObject as Map);
      final ts = DateTime.parse(json["timestamp"] as String);
      final trade = Trade(
        uuid: oldTrade?.uuid ?? const Uuid().v1(),
        tradeId: json["id"] as String,
        rateType: json["type"] as String,
        direction: "direct",
        timestamp: ts,
        updatedAt: DateTime.tryParse(json["updated_at"] as String? ?? "") ?? ts,
        payInCurrency: json["currency_from"] as String,
        payInAmount: json["amount_from"] as String,
        payInAddress: json["address_from"] as String,
        payInNetwork: "",
        payInExtraId: json["extra_id_from"] as String? ?? "",
        payInTxid: json["tx_from"] as String? ?? "",
        payOutCurrency: json["currency_to"] as String,
        payOutAmount: json["amount_to"] as String,
        payOutAddress: json["address_to"] as String,
        payOutNetwork: "",
        payOutExtraId: json["extra_id_to"] as String? ?? "",
        payOutTxid: json["tx_to"] as String? ?? "",
        refundAddress: json["user_refund_address"] as String,
        refundExtraId: json["user_refund_extra_id"] as String,
        status: json["status"] as String,
        exchangeName: SimpleSwapExchange.exchangeName,
      );

      return ExchangeResponse(value: trade);
    } catch (e, s) {
      Logging.instance.e(
        "getExchange exception",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  /// returns the minimal exchange amount
  Future<ExchangeResponse<Range>> getRange({
    required bool isFixedRate,
    required String currencyFrom,
    required String currencyTo,
    String? apiKey,
  }) async {
    final uri = _buildUri(
      "/get_ranges",
      {
        "api_key": apiKey ?? kSimpleSwapApiKey,
        "fixed": isFixedRate.toString(),
        "currency_from": currencyFrom,
        "currency_to": currencyTo,
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);

      final json = Map<String, dynamic>.from(jsonObject as Map);
      return ExchangeResponse(
        value: Range(
          max: Decimal.tryParse(json["max"] as String? ?? ""),
          min: Decimal.tryParse(json["min"] as String? ?? ""),
        ),
      );
    } catch (e, s) {
      Logging.instance.e(
        "getRange exception",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  Future<ExchangeResponse<List<FixedRateMarket>>> getFixedRateMarketInfo({
    String? apiKey,
  }) async {
    final uri = _buildUri(
      "/get_market_info",
      null,
      // {
      //   "api_key": apiKey ?? kSimpleSwapApiKey,
      //   "fixed": isFixedRate.toString(),
      //   "currency_from": currencyFrom,
      //   "currency_to": currencyTo,
      // },
    );

    try {
      final jsonArray = await _makeGetRequest(uri);

      try {
        final result = await compute(
          _parseFixedRateMarketsJson,
          jsonArray as List,
        );
        return result;
      } catch (e, s) {
        Logging.instance.e(
          "getAvailableFixedRateMarkets exception: ",
          error: e,
          stackTrace: s,
        );
        return ExchangeResponse(
          exception: ExchangeException(
            "Error: $jsonArray",
            ExchangeExceptionType.serializeResponseError,
          ),
        );
      }
    } catch (e, s) {
      Logging.instance.e(
        "getAvailableFixedRateMarkets exception: ",
        error: e,
        stackTrace: s,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
          ExchangeExceptionType.generic,
        ),
      );
    }
  }

  ExchangeResponse<List<FixedRateMarket>> _parseFixedRateMarketsJson(
    List<dynamic> jsonArray,
  ) {
    try {
      final List<FixedRateMarket> markets = [];
      for (final json in jsonArray) {
        try {
          final map = Map<String, dynamic>.from(json as Map);
          markets.add(
            FixedRateMarket(
              from: map["currency_from"] as String,
              to: map["currency_to"] as String,
              min: Decimal.parse(map["min"] as String),
              max: Decimal.parse(map["max"] as String),
              rate: Decimal.parse(map["rate"] as String),
              minerFee: null,
            ),
          );
        } catch (_) {
          return ExchangeResponse(
            exception: ExchangeException(
              "Failed to serialize $json",
              ExchangeExceptionType.serializeResponseError,
            ),
          );
        }
      }
      return ExchangeResponse(value: markets);
    } catch (_) {
      rethrow;
    }
  }
}
