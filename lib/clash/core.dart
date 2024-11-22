import 'dart:async';
import 'dart:io';

import 'package:fl_clash/clash/hub.dart';
import 'package:fl_clash/clash/interface.dart';
import 'package:fl_clash/clash/lib.dart';
import 'package:fl_clash/models/models.dart';

class ClashCore {
  static ClashCore? _instance;
  late ClashInterface clashInterface;

  ClashCore._internal() {
    if (Platform.isAndroid) {
      clashInterface = ClashLib();
    } else {
      clashInterface = ClashHub();
    }
  }

  factory ClashCore() {
    _instance ??= ClashCore._internal();
    return _instance!;
  }

  Future<bool> init(String homeDir) async {
    return clashInterface.init(homeDir);
  }

  shutdown() {}

  bool get isInit => false;

  Future<String> validateConfig(String data) {
    final completer = Completer<String>();
    return completer.future;
  }

  Future<String> updateConfig(UpdateConfigParams updateConfigParams) {
    final completer = Completer<String>();
    return completer.future;
  }

  initMessage() {}

  Future<List<Group>> getProxiesGroups() async {
    return [];
  }

  Future<List<ExternalProvider>> getExternalProviders() async {
    return [];
  }

  ExternalProvider? getExternalProvider(String externalProviderName) {
    return null;
  }

  Future<String> updateGeoData({
    required String geoType,
    required String geoName,
  }) {
    final completer = Completer<String>();
    return completer.future;
  }

  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  }) {
    final completer = Completer<String>();
    return completer.future;
  }

  Future<String> updateExternalProvider({
    required String providerName,
  }) {
    final completer = Completer<String>();
    return completer.future;
  }

  changeProxy(ChangeProxyParams changeProxyParams) {}

  start() {}

  stop() {}

  Future<Delay> getDelay(String proxyName) {
    final completer = Completer<Delay>();
    return completer.future;
  }

  clearEffect(String profileId) {}

  setState(CoreState state) {}

  String getCurrentProfileName() {
    return "";
  }

  AndroidVpnOptions getAndroidVpnOptions() {
    return AndroidVpnOptions.fromJson(Map());
  }

  Traffic getTraffic() {
    return Traffic();
  }

  Traffic getTotalTraffic() {
    return Traffic();
  }

  void resetTraffic() {}

  void startLog() {}

  stopLog() {}

  startTun(int fd, int port) {}

  updateDns(String dns) {}

  requestGc() {}

  void stopTun() {}

  void setProcessMap(ProcessMapItem processMapItem) {}

  void setFdMap(int fd) {}

  DateTime? getRunTime() {}

  List<Connection> getConnections() {
    return [];
  }

  closeConnection(String id) {}

  closeConnections() {}
}

final clashCore = ClashCore();
