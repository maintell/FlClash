import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/clash/interface.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../common/path.dart';

class ClashCore {
  static ClashCore? _instance;
  late ClashInterface clashInterface;

  ClashCore._internal() {
    if (Platform.isAndroid) {
      clashInterface = clashLib!;
    } else {
      clashInterface = clashService!;
    }
  }

  factory ClashCore() {
    _instance ??= ClashCore._internal();
    return _instance!;
  }

  Future<void> _initGeo() async {
    final homePath = await appPath.getHomeDirPath();
    final homeDir = Directory(homePath);
    final isExists = await homeDir.exists();
    if (!isExists) {
      await homeDir.create(recursive: true);
    }
    const geoFileNameList = [
      mmdbFileName,
      geoIpFileName,
      geoSiteFileName,
      asnFileName,
    ];
    try {
      for (final geoFileName in geoFileNameList) {
        final geoFile = File(
          join(homePath, geoFileName),
        );
        final isExists = await geoFile.exists();
        if (isExists) {
          continue;
        }
        final data = await rootBundle.load('assets/data/$geoFileName');
        List<int> bytes = data.buffer.asUint8List();
        await geoFile.writeAsBytes(bytes, flush: true);
      }
    } catch (e) {
      exit(0);
    }
  }

  Future<bool> init({
    required ClashConfig clashConfig,
    required Config config,
  }) async {
    await _initGeo();
    final homeDirPath = await appPath.getHomeDirPath();
    return await clashInterface.init(homeDirPath);
  }

  shutdown() async {
    await clashInterface.shutdown();
  }

  FutureOr<bool> get isInit => clashInterface.isInit;

  FutureOr<String> validateConfig(String data) {
    return clashInterface.validateConfig(data);
  }

  FutureOr<String> updateConfig(UpdateConfigParams updateConfigParams) {
    return clashInterface.updateConfig(updateConfigParams);
  }

  Future<List<Group>> getProxiesGroups() async {
    final proxiesRawString = await clashInterface.getProxies();
    return Isolate.run<List<Group>>(() {
      if (proxiesRawString.isEmpty) return [];
      final proxies = (json.decode(proxiesRawString) ?? {}) as Map;
      if (proxies.isEmpty) return [];
      final groupNames = [
        UsedProxy.GLOBAL.name,
        ...(proxies[UsedProxy.GLOBAL.name]["all"] as List).where((e) {
          final proxy = proxies[e] ?? {};
          return GroupTypeExtension.valueList.contains(proxy['type']);
        })
      ];
      final groupsRaw = groupNames.map((groupName) {
        final group = proxies[groupName];
        group["all"] = ((group["all"] ?? []) as List)
            .map(
              (name) => proxies[name],
            )
            .where((proxy) => proxy != null)
            .toList();
        return group;
      }).toList();
      return groupsRaw
          .map(
            (e) => Group.fromJson(e),
          )
          .toList();
    });
  }

  FutureOr<bool> changeProxy(ChangeProxyParams changeProxyParams) async {
    return await clashInterface.changeProxy(changeProxyParams);
  }

  Future<List<ExternalProvider>> getExternalProviders() async {
    final externalProvidersRawString =
        await clashInterface.getExternalProviders();
    return Isolate.run<List<ExternalProvider>>(
      () {
        final externalProviders =
            (json.decode(externalProvidersRawString) as List<dynamic>)
                .map(
                  (item) => ExternalProvider.fromJson(item),
                )
                .toList();
        return externalProviders;
      },
    );
  }

  Future<ExternalProvider?> getExternalProvider(
      String externalProviderName) async {
    final externalProvidersRawString =
        await clashInterface.getExternalProvider(externalProviderName);
    if (externalProvidersRawString == null) {
      return null;
    }
    return ExternalProvider.fromJson(json.decode(externalProvidersRawString));
  }

  Future<String> updateGeoData({
    required String geoType,
    required String geoName,
  }) {
    return clashInterface.updateGeoData(geoType: geoType, geoName: geoName);
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

  startListener() {}

  stopListener() {}

  Future<Delay> getDelay(String proxyName) {
    final completer = Completer<Delay>();
    return completer.future;
  }

  Future<Traffic> getTraffic() async {
    final trafficString = await clashInterface.getTraffic();
    return Traffic.fromMap(json.decode(trafficString));
  }

  Future<Traffic> getTotalTraffic() async {
    final totalTrafficString = await clashInterface.getTotalTraffic();
    return Traffic.fromMap(json.decode(totalTrafficString));
  }

  resetTraffic() {
    clashInterface.resetTraffic();
  }

  startLog() {
    clashInterface.startLog();
  }

  stopLog() {
    clashInterface.stopLog();
  }

  requestGc() {
    clashInterface.forceGc();
  }

  List<Connection> getConnections() {
    return [];
  }

  closeConnection(String id) {}

  closeConnections() {}
}

final clashCore = ClashCore();
