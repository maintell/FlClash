import 'dart:async';

import 'package:fl_clash/models/models.dart';

mixin ClashInterface {
  FutureOr<bool> init(String homeDir);

  FutureOr<void> shutdown();

  FutureOr<bool> get isInit;

  forceGc();

  FutureOr<String> validateConfig(String data);

  FutureOr<String> updateConfig(UpdateConfigParams updateConfigParams);

  FutureOr<String> getProxies();

  FutureOr<bool> changeProxy(ChangeProxyParams changeProxyParams);

  FutureOr<String> getExternalProviders();

  FutureOr<String>? getExternalProvider(String externalProviderName);

  Future<String> updateGeoData({
    required String geoType,
    required String geoName,
  });

  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  });

  Future<String> updateExternalProvider({required String providerName});

  FutureOr<String> getTraffic();

  FutureOr<String> getTotalTraffic();

  resetTraffic();

  startLog();

  stopLog();
}
