// Mocks generated by Mockito 5.4.4 from annotations
// in stackwallet/test/screen_tests/exchange/exchange_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:ui' as _i13;

import 'package:decimal/decimal.dart' as _i19;
import 'package:logger/logger.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:stackwallet/models/exchange/change_now/cn_exchange_transaction.dart'
    as _i22;
import 'package:stackwallet/models/exchange/change_now/cn_exchange_transaction_status.dart'
    as _i23;
import 'package:stackwallet/models/exchange/response_objects/estimate.dart'
    as _i21;
import 'package:stackwallet/models/exchange/response_objects/range.dart'
    as _i20;
import 'package:stackwallet/models/exchange/response_objects/trade.dart'
    as _i15;
import 'package:stackwallet/models/isar/exchange_cache/currency.dart' as _i18;
import 'package:stackwallet/networking/http.dart' as _i3;
import 'package:stackwallet/services/exchange/change_now/change_now_api.dart'
    as _i17;
import 'package:stackwallet/services/exchange/exchange_response.dart' as _i4;
import 'package:stackwallet/services/trade_notes_service.dart' as _i16;
import 'package:stackwallet/services/trade_service.dart' as _i14;
import 'package:stackwallet/utilities/amount/amount_unit.dart' as _i11;
import 'package:stackwallet/utilities/enums/backup_frequency_type.dart' as _i8;
import 'package:stackwallet/utilities/enums/sync_type_enum.dart' as _i6;
import 'package:stackwallet/utilities/prefs.dart' as _i5;
import 'package:stackwallet/wallets/crypto_currency/crypto_currency.dart'
    as _i12;
import 'package:stackwallet/wallets/wallet/wallet_mixin_interfaces/cash_fusion_interface.dart'
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

class _FakeFusionInfo_0 extends _i1.SmartFake implements _i2.FusionInfo {
  _FakeFusionInfo_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHTTP_1 extends _i1.SmartFake implements _i3.HTTP {
  _FakeHTTP_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExchangeResponse_2<T> extends _i1.SmartFake
    implements _i4.ExchangeResponse<T> {
  _FakeExchangeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Prefs].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrefs extends _i1.Mock implements _i5.Prefs {
  MockPrefs() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isInitialized => (super.noSuchMethod(
        Invocation.getter(#isInitialized),
        returnValue: false,
      ) as bool);

  @override
  int get lastUnlockedTimeout => (super.noSuchMethod(
        Invocation.getter(#lastUnlockedTimeout),
        returnValue: 0,
      ) as int);

  @override
  set lastUnlockedTimeout(int? lastUnlockedTimeout) => super.noSuchMethod(
        Invocation.setter(
          #lastUnlockedTimeout,
          lastUnlockedTimeout,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get lastUnlocked => (super.noSuchMethod(
        Invocation.getter(#lastUnlocked),
        returnValue: 0,
      ) as int);

  @override
  set lastUnlocked(int? lastUnlocked) => super.noSuchMethod(
        Invocation.setter(
          #lastUnlocked,
          lastUnlocked,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get currentNotificationId => (super.noSuchMethod(
        Invocation.getter(#currentNotificationId),
        returnValue: 0,
      ) as int);

  @override
  List<String> get walletIdsSyncOnStartup => (super.noSuchMethod(
        Invocation.getter(#walletIdsSyncOnStartup),
        returnValue: <String>[],
      ) as List<String>);

  @override
  set walletIdsSyncOnStartup(List<String>? walletIdsSyncOnStartup) =>
      super.noSuchMethod(
        Invocation.setter(
          #walletIdsSyncOnStartup,
          walletIdsSyncOnStartup,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.SyncingType get syncType => (super.noSuchMethod(
        Invocation.getter(#syncType),
        returnValue: _i6.SyncingType.currentWalletOnly,
      ) as _i6.SyncingType);

  @override
  set syncType(_i6.SyncingType? syncType) => super.noSuchMethod(
        Invocation.setter(
          #syncType,
          syncType,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get wifiOnly => (super.noSuchMethod(
        Invocation.getter(#wifiOnly),
        returnValue: false,
      ) as bool);

  @override
  set wifiOnly(bool? wifiOnly) => super.noSuchMethod(
        Invocation.setter(
          #wifiOnly,
          wifiOnly,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get showFavoriteWallets => (super.noSuchMethod(
        Invocation.getter(#showFavoriteWallets),
        returnValue: false,
      ) as bool);

  @override
  set showFavoriteWallets(bool? showFavoriteWallets) => super.noSuchMethod(
        Invocation.setter(
          #showFavoriteWallets,
          showFavoriteWallets,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get language => (super.noSuchMethod(
        Invocation.getter(#language),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#language),
        ),
      ) as String);

  @override
  set language(String? newLanguage) => super.noSuchMethod(
        Invocation.setter(
          #language,
          newLanguage,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get currency => (super.noSuchMethod(
        Invocation.getter(#currency),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#currency),
        ),
      ) as String);

  @override
  set currency(String? newCurrency) => super.noSuchMethod(
        Invocation.setter(
          #currency,
          newCurrency,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get randomizePIN => (super.noSuchMethod(
        Invocation.getter(#randomizePIN),
        returnValue: false,
      ) as bool);

  @override
  set randomizePIN(bool? randomizePIN) => super.noSuchMethod(
        Invocation.setter(
          #randomizePIN,
          randomizePIN,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get useBiometrics => (super.noSuchMethod(
        Invocation.getter(#useBiometrics),
        returnValue: false,
      ) as bool);

  @override
  set useBiometrics(bool? useBiometrics) => super.noSuchMethod(
        Invocation.setter(
          #useBiometrics,
          useBiometrics,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasPin => (super.noSuchMethod(
        Invocation.getter(#hasPin),
        returnValue: false,
      ) as bool);

  @override
  set hasPin(bool? hasPin) => super.noSuchMethod(
        Invocation.setter(
          #hasPin,
          hasPin,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasDuressPin => (super.noSuchMethod(
        Invocation.getter(#hasDuressPin),
        returnValue: false,
      ) as bool);

  @override
  set hasDuressPin(bool? hasDuressPin) => super.noSuchMethod(
        Invocation.setter(
          #hasDuressPin,
          hasDuressPin,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get biometricsDuress => (super.noSuchMethod(
        Invocation.getter(#biometricsDuress),
        returnValue: false,
      ) as bool);

  @override
  set biometricsDuress(bool? biometricsDuress) => super.noSuchMethod(
        Invocation.setter(
          #biometricsDuress,
          biometricsDuress,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get familiarity => (super.noSuchMethod(
        Invocation.getter(#familiarity),
        returnValue: 0,
      ) as int);

  @override
  set familiarity(int? familiarity) => super.noSuchMethod(
        Invocation.setter(
          #familiarity,
          familiarity,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get torKillSwitch => (super.noSuchMethod(
        Invocation.getter(#torKillSwitch),
        returnValue: false,
      ) as bool);

  @override
  set torKillSwitch(bool? torKillswitch) => super.noSuchMethod(
        Invocation.setter(
          #torKillSwitch,
          torKillswitch,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get showTestNetCoins => (super.noSuchMethod(
        Invocation.getter(#showTestNetCoins),
        returnValue: false,
      ) as bool);

  @override
  set showTestNetCoins(bool? showTestNetCoins) => super.noSuchMethod(
        Invocation.setter(
          #showTestNetCoins,
          showTestNetCoins,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get isAutoBackupEnabled => (super.noSuchMethod(
        Invocation.getter(#isAutoBackupEnabled),
        returnValue: false,
      ) as bool);

  @override
  set isAutoBackupEnabled(bool? isAutoBackupEnabled) => super.noSuchMethod(
        Invocation.setter(
          #isAutoBackupEnabled,
          isAutoBackupEnabled,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set autoBackupLocation(String? autoBackupLocation) => super.noSuchMethod(
        Invocation.setter(
          #autoBackupLocation,
          autoBackupLocation,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.BackupFrequencyType get backupFrequencyType => (super.noSuchMethod(
        Invocation.getter(#backupFrequencyType),
        returnValue: _i8.BackupFrequencyType.everyTenMinutes,
      ) as _i8.BackupFrequencyType);

  @override
  set backupFrequencyType(_i8.BackupFrequencyType? backupFrequencyType) =>
      super.noSuchMethod(
        Invocation.setter(
          #backupFrequencyType,
          backupFrequencyType,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set lastAutoBackup(DateTime? lastAutoBackup) => super.noSuchMethod(
        Invocation.setter(
          #lastAutoBackup,
          lastAutoBackup,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hideBlockExplorerWarning => (super.noSuchMethod(
        Invocation.getter(#hideBlockExplorerWarning),
        returnValue: false,
      ) as bool);

  @override
  set hideBlockExplorerWarning(bool? hideBlockExplorerWarning) =>
      super.noSuchMethod(
        Invocation.setter(
          #hideBlockExplorerWarning,
          hideBlockExplorerWarning,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get gotoWalletOnStartup => (super.noSuchMethod(
        Invocation.getter(#gotoWalletOnStartup),
        returnValue: false,
      ) as bool);

  @override
  set gotoWalletOnStartup(bool? gotoWalletOnStartup) => super.noSuchMethod(
        Invocation.setter(
          #gotoWalletOnStartup,
          gotoWalletOnStartup,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set startupWalletId(String? startupWalletId) => super.noSuchMethod(
        Invocation.setter(
          #startupWalletId,
          startupWalletId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get externalCalls => (super.noSuchMethod(
        Invocation.getter(#externalCalls),
        returnValue: false,
      ) as bool);

  @override
  set externalCalls(bool? externalCalls) => super.noSuchMethod(
        Invocation.setter(
          #externalCalls,
          externalCalls,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get enableCoinControl => (super.noSuchMethod(
        Invocation.getter(#enableCoinControl),
        returnValue: false,
      ) as bool);

  @override
  set enableCoinControl(bool? enableCoinControl) => super.noSuchMethod(
        Invocation.setter(
          #enableCoinControl,
          enableCoinControl,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get enableSystemBrightness => (super.noSuchMethod(
        Invocation.getter(#enableSystemBrightness),
        returnValue: false,
      ) as bool);

  @override
  set enableSystemBrightness(bool? enableSystemBrightness) =>
      super.noSuchMethod(
        Invocation.setter(
          #enableSystemBrightness,
          enableSystemBrightness,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get themeId => (super.noSuchMethod(
        Invocation.getter(#themeId),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#themeId),
        ),
      ) as String);

  @override
  set themeId(String? themeId) => super.noSuchMethod(
        Invocation.setter(
          #themeId,
          themeId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get systemBrightnessLightThemeId => (super.noSuchMethod(
        Invocation.getter(#systemBrightnessLightThemeId),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#systemBrightnessLightThemeId),
        ),
      ) as String);

  @override
  set systemBrightnessLightThemeId(String? systemBrightnessLightThemeId) =>
      super.noSuchMethod(
        Invocation.setter(
          #systemBrightnessLightThemeId,
          systemBrightnessLightThemeId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get systemBrightnessDarkThemeId => (super.noSuchMethod(
        Invocation.getter(#systemBrightnessDarkThemeId),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#systemBrightnessDarkThemeId),
        ),
      ) as String);

  @override
  set systemBrightnessDarkThemeId(String? systemBrightnessDarkThemeId) =>
      super.noSuchMethod(
        Invocation.setter(
          #systemBrightnessDarkThemeId,
          systemBrightnessDarkThemeId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get useTor => (super.noSuchMethod(
        Invocation.getter(#useTor),
        returnValue: false,
      ) as bool);

  @override
  set useTor(bool? useTor) => super.noSuchMethod(
        Invocation.setter(
          #useTor,
          useTor,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get autoPin => (super.noSuchMethod(
        Invocation.getter(#autoPin),
        returnValue: false,
      ) as bool);

  @override
  set autoPin(bool? autoPin) => super.noSuchMethod(
        Invocation.setter(
          #autoPin,
          autoPin,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get enableExchange => (super.noSuchMethod(
        Invocation.getter(#enableExchange),
        returnValue: false,
      ) as bool);

  @override
  set enableExchange(bool? showExchange) => super.noSuchMethod(
        Invocation.setter(
          #enableExchange,
          showExchange,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get advancedFiroFeatures => (super.noSuchMethod(
        Invocation.getter(#advancedFiroFeatures),
        returnValue: false,
      ) as bool);

  @override
  set advancedFiroFeatures(bool? advancedFiroFeatures) => super.noSuchMethod(
        Invocation.setter(
          #advancedFiroFeatures,
          advancedFiroFeatures,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set logsPath(String? logsPath) => super.noSuchMethod(
        Invocation.setter(
          #logsPath,
          logsPath,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Level get logLevel => (super.noSuchMethod(
        Invocation.getter(#logLevel),
        returnValue: _i9.Level.all,
      ) as _i9.Level);

  @override
  set logLevel(_i9.Level? logLevel) => super.noSuchMethod(
        Invocation.setter(
          #logLevel,
          logLevel,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i10.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> incrementCurrentNotificationIndex() => (super.noSuchMethod(
        Invocation.method(
          #incrementCurrentNotificationIndex,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<bool> isExternalCallsSet() => (super.noSuchMethod(
        Invocation.method(
          #isExternalCallsSet,
          [],
        ),
        returnValue: _i10.Future<bool>.value(false),
      ) as _i10.Future<bool>);

  @override
  _i10.Future<void> saveUserID(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #saveUserID,
          [userId],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> saveSignupEpoch(int? signupEpoch) => (super.noSuchMethod(
        Invocation.method(
          #saveSignupEpoch,
          [signupEpoch],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i11.AmountUnit amountUnit(_i12.CryptoCurrency? coin) => (super.noSuchMethod(
        Invocation.method(
          #amountUnit,
          [coin],
        ),
        returnValue: _i11.AmountUnit.normal,
      ) as _i11.AmountUnit);

  @override
  void updateAmountUnit({
    required _i12.CryptoCurrency? coin,
    required _i11.AmountUnit? amountUnit,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #updateAmountUnit,
          [],
          {
            #coin: coin,
            #amountUnit: amountUnit,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  int maxDecimals(_i12.CryptoCurrency? coin) => (super.noSuchMethod(
        Invocation.method(
          #maxDecimals,
          [coin],
        ),
        returnValue: 0,
      ) as int);

  @override
  void updateMaxDecimals({
    required _i12.CryptoCurrency? coin,
    required int? maxDecimals,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #updateMaxDecimals,
          [],
          {
            #coin: coin,
            #maxDecimals: maxDecimals,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.FusionInfo getFusionServerInfo(_i12.CryptoCurrency? coin) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFusionServerInfo,
          [coin],
        ),
        returnValue: _FakeFusionInfo_0(
          this,
          Invocation.method(
            #getFusionServerInfo,
            [coin],
          ),
        ),
      ) as _i2.FusionInfo);

  @override
  void setFusionServerInfo(
    _i12.CryptoCurrency? coin,
    _i2.FusionInfo? fusionServerInfo,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setFusionServerInfo,
          [
            coin,
            fusionServerInfo,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TradesService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTradesService extends _i1.Mock implements _i14.TradesService {
  MockTradesService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i15.Trade> get trades => (super.noSuchMethod(
        Invocation.getter(#trades),
        returnValue: <_i15.Trade>[],
      ) as List<_i15.Trade>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i15.Trade? get(String? tradeId) => (super.noSuchMethod(Invocation.method(
        #get,
        [tradeId],
      )) as _i15.Trade?);

  @override
  _i10.Future<void> add({
    required _i15.Trade? trade,
    required bool? shouldNotifyListeners,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [],
          {
            #trade: trade,
            #shouldNotifyListeners: shouldNotifyListeners,
          },
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> edit({
    required _i15.Trade? trade,
    required bool? shouldNotifyListeners,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #edit,
          [],
          {
            #trade: trade,
            #shouldNotifyListeners: shouldNotifyListeners,
          },
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> delete({
    required _i15.Trade? trade,
    required bool? shouldNotifyListeners,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #trade: trade,
            #shouldNotifyListeners: shouldNotifyListeners,
          },
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> deleteByUuid({
    required String? uuid,
    required bool? shouldNotifyListeners,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteByUuid,
          [],
          {
            #uuid: uuid,
            #shouldNotifyListeners: shouldNotifyListeners,
          },
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void addListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TradeNotesService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTradeNotesService extends _i1.Mock implements _i16.TradeNotesService {
  MockTradeNotesService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, String> get all => (super.noSuchMethod(
        Invocation.getter(#all),
        returnValue: <String, String>{},
      ) as Map<String, String>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  String getNote({required String? tradeId}) => (super.noSuchMethod(
        Invocation.method(
          #getNote,
          [],
          {#tradeId: tradeId},
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #getNote,
            [],
            {#tradeId: tradeId},
          ),
        ),
      ) as String);

  @override
  _i10.Future<void> set({
    required String? tradeId,
    required String? note,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #set,
          [],
          {
            #tradeId: tradeId,
            #note: note,
          },
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> delete({required String? tradeId}) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {#tradeId: tradeId},
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void addListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ChangeNowAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockChangeNowAPI extends _i1.Mock implements _i17.ChangeNowAPI {
  MockChangeNowAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.HTTP get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeHTTP_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.HTTP);

  @override
  _i10.Future<_i4.ExchangeResponse<List<_i18.Currency>>>
      getAvailableCurrencies({
    bool? active,
    bool? buy,
    bool? sell,
    _i17.CNFlow? flow = _i17.CNFlow.standard,
    String? apiKey,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #getAvailableCurrencies,
              [],
              {
                #active: active,
                #buy: buy,
                #sell: sell,
                #flow: flow,
                #apiKey: apiKey,
              },
            ),
            returnValue:
                _i10.Future<_i4.ExchangeResponse<List<_i18.Currency>>>.value(
                    _FakeExchangeResponse_2<List<_i18.Currency>>(
              this,
              Invocation.method(
                #getAvailableCurrencies,
                [],
                {
                  #active: active,
                  #buy: buy,
                  #sell: sell,
                  #flow: flow,
                  #apiKey: apiKey,
                },
              ),
            )),
          ) as _i10.Future<_i4.ExchangeResponse<List<_i18.Currency>>>);

  @override
  _i10.Future<_i4.ExchangeResponse<_i19.Decimal>> getMinimalExchangeAmount({
    required String? fromCurrency,
    required String? toCurrency,
    String? fromNetwork,
    String? toNetwork,
    _i17.CNFlow? flow = _i17.CNFlow.standard,
    String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMinimalExchangeAmount,
          [],
          {
            #fromCurrency: fromCurrency,
            #toCurrency: toCurrency,
            #fromNetwork: fromNetwork,
            #toNetwork: toNetwork,
            #flow: flow,
            #apiKey: apiKey,
          },
        ),
        returnValue: _i10.Future<_i4.ExchangeResponse<_i19.Decimal>>.value(
            _FakeExchangeResponse_2<_i19.Decimal>(
          this,
          Invocation.method(
            #getMinimalExchangeAmount,
            [],
            {
              #fromCurrency: fromCurrency,
              #toCurrency: toCurrency,
              #fromNetwork: fromNetwork,
              #toNetwork: toNetwork,
              #flow: flow,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i10.Future<_i4.ExchangeResponse<_i19.Decimal>>);

  @override
  _i10.Future<_i4.ExchangeResponse<_i20.Range>> getRange({
    required String? fromCurrency,
    required String? toCurrency,
    String? fromNetwork,
    String? toNetwork,
    _i17.CNFlow? flow = _i17.CNFlow.standard,
    String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRange,
          [],
          {
            #fromCurrency: fromCurrency,
            #toCurrency: toCurrency,
            #fromNetwork: fromNetwork,
            #toNetwork: toNetwork,
            #flow: flow,
            #apiKey: apiKey,
          },
        ),
        returnValue: _i10.Future<_i4.ExchangeResponse<_i20.Range>>.value(
            _FakeExchangeResponse_2<_i20.Range>(
          this,
          Invocation.method(
            #getRange,
            [],
            {
              #fromCurrency: fromCurrency,
              #toCurrency: toCurrency,
              #fromNetwork: fromNetwork,
              #toNetwork: toNetwork,
              #flow: flow,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i10.Future<_i4.ExchangeResponse<_i20.Range>>);

  @override
  _i10.Future<_i4.ExchangeResponse<_i21.Estimate>> getEstimatedExchangeAmount({
    required String? fromCurrency,
    required String? toCurrency,
    _i19.Decimal? fromAmount,
    _i19.Decimal? toAmount,
    String? fromNetwork,
    String? toNetwork,
    _i17.CNFlow? flow = _i17.CNFlow.standard,
    _i17.CNExchangeType? type = _i17.CNExchangeType.direct,
    bool? useRateId,
    bool? isTopUp,
    String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEstimatedExchangeAmount,
          [],
          {
            #fromCurrency: fromCurrency,
            #toCurrency: toCurrency,
            #fromAmount: fromAmount,
            #toAmount: toAmount,
            #fromNetwork: fromNetwork,
            #toNetwork: toNetwork,
            #flow: flow,
            #type: type,
            #useRateId: useRateId,
            #isTopUp: isTopUp,
            #apiKey: apiKey,
          },
        ),
        returnValue: _i10.Future<_i4.ExchangeResponse<_i21.Estimate>>.value(
            _FakeExchangeResponse_2<_i21.Estimate>(
          this,
          Invocation.method(
            #getEstimatedExchangeAmount,
            [],
            {
              #fromCurrency: fromCurrency,
              #toCurrency: toCurrency,
              #fromAmount: fromAmount,
              #toAmount: toAmount,
              #fromNetwork: fromNetwork,
              #toNetwork: toNetwork,
              #flow: flow,
              #type: type,
              #useRateId: useRateId,
              #isTopUp: isTopUp,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i10.Future<_i4.ExchangeResponse<_i21.Estimate>>);

  @override
  _i10.Future<_i4.ExchangeResponse<_i22.CNExchangeTransaction>>
      createExchangeTransaction({
    required String? fromCurrency,
    required String? fromNetwork,
    required String? toCurrency,
    required String? toNetwork,
    _i19.Decimal? fromAmount,
    _i19.Decimal? toAmount,
    _i17.CNFlow? flow = _i17.CNFlow.standard,
    _i17.CNExchangeType? type = _i17.CNExchangeType.direct,
    required String? address,
    String? extraId,
    String? refundAddress,
    String? refundExtraId,
    String? userId,
    String? payload,
    String? contactEmail,
    required String? rateId,
    String? apiKey,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #createExchangeTransaction,
              [],
              {
                #fromCurrency: fromCurrency,
                #fromNetwork: fromNetwork,
                #toCurrency: toCurrency,
                #toNetwork: toNetwork,
                #fromAmount: fromAmount,
                #toAmount: toAmount,
                #flow: flow,
                #type: type,
                #address: address,
                #extraId: extraId,
                #refundAddress: refundAddress,
                #refundExtraId: refundExtraId,
                #userId: userId,
                #payload: payload,
                #contactEmail: contactEmail,
                #rateId: rateId,
                #apiKey: apiKey,
              },
            ),
            returnValue: _i10
                .Future<_i4.ExchangeResponse<_i22.CNExchangeTransaction>>.value(
                _FakeExchangeResponse_2<_i22.CNExchangeTransaction>(
              this,
              Invocation.method(
                #createExchangeTransaction,
                [],
                {
                  #fromCurrency: fromCurrency,
                  #fromNetwork: fromNetwork,
                  #toCurrency: toCurrency,
                  #toNetwork: toNetwork,
                  #fromAmount: fromAmount,
                  #toAmount: toAmount,
                  #flow: flow,
                  #type: type,
                  #address: address,
                  #extraId: extraId,
                  #refundAddress: refundAddress,
                  #refundExtraId: refundExtraId,
                  #userId: userId,
                  #payload: payload,
                  #contactEmail: contactEmail,
                  #rateId: rateId,
                  #apiKey: apiKey,
                },
              ),
            )),
          ) as _i10.Future<_i4.ExchangeResponse<_i22.CNExchangeTransaction>>);

  @override
  _i10.Future<_i4.ExchangeResponse<_i23.CNExchangeTransactionStatus>>
      getTransactionStatus({
    required String? id,
    String? apiKey,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #getTransactionStatus,
              [],
              {
                #id: id,
                #apiKey: apiKey,
              },
            ),
            returnValue: _i10.Future<
                    _i4
                    .ExchangeResponse<_i23.CNExchangeTransactionStatus>>.value(
                _FakeExchangeResponse_2<_i23.CNExchangeTransactionStatus>(
              this,
              Invocation.method(
                #getTransactionStatus,
                [],
                {
                  #id: id,
                  #apiKey: apiKey,
                },
              ),
            )),
          ) as _i10
              .Future<_i4.ExchangeResponse<_i23.CNExchangeTransactionStatus>>);
}
