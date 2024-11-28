import 'dart:async';

import 'package:fl_clash/models/models.dart';

mixin ClashInterface {
  FutureOr<bool> init(String homeDir);

  FutureOr<void> shutdown();

  FutureOr<bool> get isInit;

  forceGc();

  FutureOr<String> validateConfig(String data);

  Future<String> asyncTestDelay(String proxyName);

  FutureOr<String> updateConfig(UpdateConfigParams updateConfigParams);

  FutureOr<String> getProxies();

  FutureOr<bool> changeProxy(ChangeProxyParams changeProxyParams);

  Future<bool> startListener();

  Future<bool> stopListener();

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

  FutureOr<String> getTraffic(bool value);

  FutureOr<String> getTotalTraffic(bool value);

  resetTraffic();

  startLog();

  stopLog();

  FutureOr<String> getConnections();

  FutureOr<bool> closeConnection(String id);

  FutureOr<bool> closeConnections();
}
