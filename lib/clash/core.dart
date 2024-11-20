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

  bool init(String homeDir) {
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
    // final proxiesRaw = clashFFI.getProxies();
    // final proxiesRawString = proxiesRaw.cast<Utf8>().toDartString();
    // clashFFI.freeCString(proxiesRaw);
    // return Isolate.run<List<Group>>(() {
    //   if (proxiesRawString.isEmpty) return [];
    //   final proxies = (json.decode(proxiesRawString) ?? {}) as Map;
    //   if (proxies.isEmpty) return [];
    //   final groupNames = [
    //     UsedProxy.GLOBAL.name,
    //     ...(proxies[UsedProxy.GLOBAL.name]["all"] as List).where((e) {
    //       final proxy = proxies[e] ?? {};
    //       return GroupTypeExtension.valueList.contains(proxy['type']);
    //     })
    //   ];
    //   final groupsRaw = groupNames.map((groupName) {
    //     final group = proxies[groupName];
    //     group["all"] = ((group["all"] ?? []) as List)
    //         .map(
    //           (name) => proxies[name],
    //     )
    //         .where((proxy) => proxy != null)
    //         .toList();
    //     return group;
    //   }).toList();
    //   return groupsRaw
    //       .map(
    //         (e) => Group.fromJson(e),
    //   )
    //       .toList();
    // });
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
