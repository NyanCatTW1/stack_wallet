// Mocks generated by Mockito 5.4.4 from annotations
// in stackwallet/test/services/coins/bitcoincash/bitcoincash_wallet_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:decimal/decimal.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:stackwallet/electrumx_rpc/cached_electrumx_client.dart' as _i9;
import 'package:stackwallet/electrumx_rpc/electrumx_client.dart' as _i5;
import 'package:stackwallet/models/electrumx_response/spark_models.dart' as _i3;
import 'package:stackwallet/services/transaction_notification_tracker.dart'
    as _i10;
import 'package:stackwallet/utilities/tor_plain_net_option_enum.dart' as _i6;
import 'package:stackwallet/wallets/crypto_currency/crypto_currency.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCryptoCurrency_0 extends _i1.SmartFake
    implements _i2.CryptoCurrency {
  _FakeCryptoCurrency_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_1 extends _i1.SmartFake implements Duration {
  _FakeDuration_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSparkAnonymitySetMeta_2 extends _i1.SmartFake
    implements _i3.SparkAnonymitySetMeta {
  _FakeSparkAnonymitySetMeta_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDecimal_3 extends _i1.SmartFake implements _i4.Decimal {
  _FakeDecimal_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeElectrumXClient_4 extends _i1.SmartFake
    implements _i5.ElectrumXClient {
  _FakeElectrumXClient_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ElectrumXClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockElectrumXClient extends _i1.Mock implements _i5.ElectrumXClient {
  MockElectrumXClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CryptoCurrency get cryptoCurrency => (super.noSuchMethod(
        Invocation.getter(#cryptoCurrency),
        returnValue: _FakeCryptoCurrency_0(
          this,
          Invocation.getter(#cryptoCurrency),
        ),
      ) as _i2.CryptoCurrency);

  @override
  _i6.TorPlainNetworkOption get netType => (super.noSuchMethod(
        Invocation.getter(#netType),
        returnValue: _i6.TorPlainNetworkOption.tor,
      ) as _i6.TorPlainNetworkOption);

  @override
  int get currentFailoverIndex => (super.noSuchMethod(
        Invocation.getter(#currentFailoverIndex),
        returnValue: 0,
      ) as int);

  @override
  set currentFailoverIndex(int? _currentFailoverIndex) => super.noSuchMethod(
        Invocation.setter(
          #currentFailoverIndex,
          _currentFailoverIndex,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Duration get connectionTimeoutForSpecialCaseJsonRPCClients =>
      (super.noSuchMethod(
        Invocation.getter(#connectionTimeoutForSpecialCaseJsonRPCClients),
        returnValue: _FakeDuration_1(
          this,
          Invocation.getter(#connectionTimeoutForSpecialCaseJsonRPCClients),
        ),
      ) as Duration);

  @override
  String get host => (super.noSuchMethod(
        Invocation.getter(#host),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#host),
        ),
      ) as String);

  @override
  int get port => (super.noSuchMethod(
        Invocation.getter(#port),
        returnValue: 0,
      ) as int);

  @override
  bool get useSSL => (super.noSuchMethod(
        Invocation.getter(#useSSL),
        returnValue: false,
      ) as bool);

  @override
  _i8.Future<void> closeAdapter() => (super.noSuchMethod(
        Invocation.method(
          #closeAdapter,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> checkElectrumAdapter() => (super.noSuchMethod(
        Invocation.method(
          #checkElectrumAdapter,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<dynamic> request({
    required String? command,
    List<dynamic>? args = const [],
    String? requestID,
    int? retries = 2,
    Duration? requestTimeout = const Duration(seconds: 60),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [],
          {
            #command: command,
            #args: args,
            #requestID: requestID,
            #retries: retries,
            #requestTimeout: requestTimeout,
          },
        ),
        returnValue: _i8.Future<dynamic>.value(),
      ) as _i8.Future<dynamic>);

  @override
  _i8.Future<List<dynamic>> batchRequest({
    required String? command,
    required List<dynamic>? args,
    Duration? requestTimeout = const Duration(seconds: 60),
    int? retries = 2,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #batchRequest,
          [],
          {
            #command: command,
            #args: args,
            #requestTimeout: requestTimeout,
            #retries: retries,
          },
        ),
        returnValue: _i8.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i8.Future<List<dynamic>>);

  @override
  _i8.Future<bool> ping({
    String? requestID,
    int? retryCount = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #ping,
          [],
          {
            #requestID: requestID,
            #retryCount: retryCount,
          },
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<Map<String, dynamic>> getBlockHeadTip({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBlockHeadTip,
          [],
          {#requestID: requestID},
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<Map<String, dynamic>> getServerFeatures({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getServerFeatures,
          [],
          {#requestID: requestID},
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<String> broadcastTransaction({
    required String? rawTx,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #broadcastTransaction,
          [],
          {
            #rawTx: rawTx,
            #requestID: requestID,
          },
        ),
        returnValue: _i8.Future<String>.value(_i7.dummyValue<String>(
          this,
          Invocation.method(
            #broadcastTransaction,
            [],
            {
              #rawTx: rawTx,
              #requestID: requestID,
            },
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<Map<String, dynamic>> getBalance({
    required String? scripthash,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBalance,
          [],
          {
            #scripthash: scripthash,
            #requestID: requestID,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getHistory({
    required String? scripthash,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHistory,
          [],
          {
            #scripthash: scripthash,
            #requestID: requestID,
          },
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);

  @override
  _i8.Future<List<List<Map<String, dynamic>>>> getBatchHistory(
          {required List<dynamic>? args}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBatchHistory,
          [],
          {#args: args},
        ),
        returnValue: _i8.Future<List<List<Map<String, dynamic>>>>.value(
            <List<Map<String, dynamic>>>[]),
      ) as _i8.Future<List<List<Map<String, dynamic>>>>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getUTXOs({
    required String? scripthash,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUTXOs,
          [],
          {
            #scripthash: scripthash,
            #requestID: requestID,
          },
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);

  @override
  _i8.Future<List<List<Map<String, dynamic>>>> getBatchUTXOs(
          {required List<dynamic>? args}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBatchUTXOs,
          [],
          {#args: args},
        ),
        returnValue: _i8.Future<List<List<Map<String, dynamic>>>>.value(
            <List<Map<String, dynamic>>>[]),
      ) as _i8.Future<List<List<Map<String, dynamic>>>>);

  @override
  _i8.Future<Map<String, dynamic>> getTransaction({
    required String? txHash,
    bool? verbose = true,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransaction,
          [],
          {
            #txHash: txHash,
            #verbose: verbose,
            #requestID: requestID,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<Map<String, dynamic>> getLelantusAnonymitySet({
    String? groupId = r'1',
    String? blockhash = r'',
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLelantusAnonymitySet,
          [],
          {
            #groupId: groupId,
            #blockhash: blockhash,
            #requestID: requestID,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<dynamic> getLelantusMintData({
    dynamic mints,
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLelantusMintData,
          [],
          {
            #mints: mints,
            #requestID: requestID,
          },
        ),
        returnValue: _i8.Future<dynamic>.value(),
      ) as _i8.Future<dynamic>);

  @override
  _i8.Future<Map<String, dynamic>> getLelantusUsedCoinSerials({
    String? requestID,
    required int? startNumber,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLelantusUsedCoinSerials,
          [],
          {
            #requestID: requestID,
            #startNumber: startNumber,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<int> getLelantusLatestCoinId({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLelantusLatestCoinId,
          [],
          {#requestID: requestID},
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<Map<String, dynamic>> getSparkAnonymitySet({
    String? coinGroupId = r'1',
    String? startBlockHash = r'',
    String? requestID,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkAnonymitySet,
          [],
          {
            #coinGroupId: coinGroupId,
            #startBlockHash: startBlockHash,
            #requestID: requestID,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<int> getSparkLatestCoinId({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkLatestCoinId,
          [],
          {#requestID: requestID},
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<Set<String>> getMempoolTxids({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMempoolTxids,
          [],
          {#requestID: requestID},
        ),
        returnValue: _i8.Future<Set<String>>.value(<String>{}),
      ) as _i8.Future<Set<String>>);

  @override
  _i8.Future<List<_i3.SparkMempoolData>> getMempoolSparkData({
    String? requestID,
    required List<String>? txids,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMempoolSparkData,
          [],
          {
            #requestID: requestID,
            #txids: txids,
          },
        ),
        returnValue: _i8.Future<List<_i3.SparkMempoolData>>.value(
            <_i3.SparkMempoolData>[]),
      ) as _i8.Future<List<_i3.SparkMempoolData>>);

  @override
  _i8.Future<List<List<dynamic>>> getSparkUnhashedUsedCoinsTagsWithTxHashes({
    String? requestID,
    required int? startNumber,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkUnhashedUsedCoinsTagsWithTxHashes,
          [],
          {
            #requestID: requestID,
            #startNumber: startNumber,
          },
        ),
        returnValue: _i8.Future<List<List<dynamic>>>.value(<List<dynamic>>[]),
      ) as _i8.Future<List<List<dynamic>>>);

  @override
  _i8.Future<List<({String address, String name})>> getSparkNames(
          {String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkNames,
          [],
          {#requestID: requestID},
        ),
        returnValue: _i8.Future<List<({String address, String name})>>.value(
            <({String address, String name})>[]),
      ) as _i8.Future<List<({String address, String name})>>);

  @override
  _i8.Future<({String additionalInfo, String address, int validUntil})>
      getSparkNameData({
    required String? sparkName,
    String? requestID,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #getSparkNameData,
              [],
              {
                #sparkName: sparkName,
                #requestID: requestID,
              },
            ),
            returnValue: _i8.Future<
                ({
                  String additionalInfo,
                  String address,
                  int validUntil
                })>.value((
              additionalInfo: _i7.dummyValue<String>(
                this,
                Invocation.method(
                  #getSparkNameData,
                  [],
                  {
                    #sparkName: sparkName,
                    #requestID: requestID,
                  },
                ),
              ),
              address: _i7.dummyValue<String>(
                this,
                Invocation.method(
                  #getSparkNameData,
                  [],
                  {
                    #sparkName: sparkName,
                    #requestID: requestID,
                  },
                ),
              ),
              validUntil: 0
            )),
          ) as _i8.Future<
              ({String additionalInfo, String address, int validUntil})>);

  @override
  _i8.Future<_i3.SparkAnonymitySetMeta> getSparkAnonymitySetMeta({
    String? requestID,
    required int? coinGroupId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkAnonymitySetMeta,
          [],
          {
            #requestID: requestID,
            #coinGroupId: coinGroupId,
          },
        ),
        returnValue: _i8.Future<_i3.SparkAnonymitySetMeta>.value(
            _FakeSparkAnonymitySetMeta_2(
          this,
          Invocation.method(
            #getSparkAnonymitySetMeta,
            [],
            {
              #requestID: requestID,
              #coinGroupId: coinGroupId,
            },
          ),
        )),
      ) as _i8.Future<_i3.SparkAnonymitySetMeta>);

  @override
  _i8.Future<List<dynamic>> getSparkAnonymitySetBySector({
    String? requestID,
    required int? coinGroupId,
    required String? latestBlock,
    required int? startIndex,
    required int? endIndex,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSparkAnonymitySetBySector,
          [],
          {
            #requestID: requestID,
            #coinGroupId: coinGroupId,
            #latestBlock: latestBlock,
            #startIndex: startIndex,
            #endIndex: endIndex,
          },
        ),
        returnValue: _i8.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i8.Future<List<dynamic>>);

  @override
  _i8.Future<bool> isMasterNodeCollateral({
    String? requestID,
    required String? txid,
    required int? index,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #isMasterNodeCollateral,
          [],
          {
            #requestID: requestID,
            #txid: txid,
            #index: index,
          },
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<Map<String, dynamic>> getFeeRate({String? requestID}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFeeRate,
          [],
          {#requestID: requestID},
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<_i4.Decimal> estimateFee({
    String? requestID,
    required int? blocks,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #estimateFee,
          [],
          {
            #requestID: requestID,
            #blocks: blocks,
          },
        ),
        returnValue: _i8.Future<_i4.Decimal>.value(_FakeDecimal_3(
          this,
          Invocation.method(
            #estimateFee,
            [],
            {
              #requestID: requestID,
              #blocks: blocks,
            },
          ),
        )),
      ) as _i8.Future<_i4.Decimal>);

  @override
  _i8.Future<_i4.Decimal> relayFee({String? requestID}) => (super.noSuchMethod(
        Invocation.method(
          #relayFee,
          [],
          {#requestID: requestID},
        ),
        returnValue: _i8.Future<_i4.Decimal>.value(_FakeDecimal_3(
          this,
          Invocation.method(
            #relayFee,
            [],
            {#requestID: requestID},
          ),
        )),
      ) as _i8.Future<_i4.Decimal>);
}

/// A class which mocks [CachedElectrumXClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockCachedElectrumXClient extends _i1.Mock
    implements _i9.CachedElectrumXClient {
  MockCachedElectrumXClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.ElectrumXClient get electrumXClient => (super.noSuchMethod(
        Invocation.getter(#electrumXClient),
        returnValue: _FakeElectrumXClient_4(
          this,
          Invocation.getter(#electrumXClient),
        ),
      ) as _i5.ElectrumXClient);

  @override
  _i8.Future<Map<String, dynamic>> getAnonymitySet({
    required String? groupId,
    String? blockhash = r'',
    required _i2.CryptoCurrency? cryptoCurrency,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAnonymitySet,
          [],
          {
            #groupId: groupId,
            #blockhash: blockhash,
            #cryptoCurrency: cryptoCurrency,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  String base64ToHex(String? source) => (super.noSuchMethod(
        Invocation.method(
          #base64ToHex,
          [source],
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #base64ToHex,
            [source],
          ),
        ),
      ) as String);

  @override
  String base64ToReverseHex(String? source) => (super.noSuchMethod(
        Invocation.method(
          #base64ToReverseHex,
          [source],
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #base64ToReverseHex,
            [source],
          ),
        ),
      ) as String);

  @override
  _i8.Future<Map<String, dynamic>> getTransaction({
    required String? txHash,
    required _i2.CryptoCurrency? cryptoCurrency,
    bool? verbose = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransaction,
          [],
          {
            #txHash: txHash,
            #cryptoCurrency: cryptoCurrency,
            #verbose: verbose,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);

  @override
  _i8.Future<List<String>> getUsedCoinSerials({
    required _i2.CryptoCurrency? cryptoCurrency,
    int? startNumber = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsedCoinSerials,
          [],
          {
            #cryptoCurrency: cryptoCurrency,
            #startNumber: startNumber,
          },
        ),
        returnValue: _i8.Future<List<String>>.value(<String>[]),
      ) as _i8.Future<List<String>>);

  @override
  _i8.Future<void> clearSharedTransactionCache(
          {required _i2.CryptoCurrency? cryptoCurrency}) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearSharedTransactionCache,
          [],
          {#cryptoCurrency: cryptoCurrency},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [TransactionNotificationTracker].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionNotificationTracker extends _i1.Mock
    implements _i10.TransactionNotificationTracker {
  MockTransactionNotificationTracker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get walletId => (super.noSuchMethod(
        Invocation.getter(#walletId),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#walletId),
        ),
      ) as String);

  @override
  List<String> get pendings => (super.noSuchMethod(
        Invocation.getter(#pendings),
        returnValue: <String>[],
      ) as List<String>);

  @override
  List<String> get confirmeds => (super.noSuchMethod(
        Invocation.getter(#confirmeds),
        returnValue: <String>[],
      ) as List<String>);

  @override
  bool wasNotifiedPending(String? txid) => (super.noSuchMethod(
        Invocation.method(
          #wasNotifiedPending,
          [txid],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i8.Future<void> addNotifiedPending(String? txid) => (super.noSuchMethod(
        Invocation.method(
          #addNotifiedPending,
          [txid],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  bool wasNotifiedConfirmed(String? txid) => (super.noSuchMethod(
        Invocation.method(
          #wasNotifiedConfirmed,
          [txid],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i8.Future<void> addNotifiedConfirmed(String? txid) => (super.noSuchMethod(
        Invocation.method(
          #addNotifiedConfirmed,
          [txid],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> deleteTransaction(String? txid) => (super.noSuchMethod(
        Invocation.method(
          #deleteTransaction,
          [txid],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}
