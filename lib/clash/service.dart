import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/clash/interface.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/core.dart';

class ClashService with ClashInterface {
  static ClashService? _instance;

  Completer<Socket> socketCompleter = Completer();

  Map<String, Completer> callbackCompleterMap = {};

  late final Process process;

  factory ClashService() {
    _instance ??= ClashService._internal();
    return _instance!;
  }

  ClashService._internal() {
    _connectCore(55381);
  }

  _initCore() async {
    // String currentExecutablePath = Platform.resolvedExecutable;
    // Directory currentDirectory = Directory(dirname(currentExecutablePath));
    // final path = join(currentDirectory.path, "core");
    // process = await Process.start(path, []);
    // process.stdout.listen((data) {
    //   var string = String.fromCharCodes(data);
    //   print(string);
    //   var value = int.tryParse(string);
    //   if (value != null) {
    //     _connectCore(value);
    //   }
    // });

    // final portString = String.fromCharCodes(await process.stdout.first).trim();
    // final port = int.parse(portString);
    // _connectCore(port);
  }

  _connectCore(int port) async {
    print("_connectCore ==>");
    if (socketCompleter.isCompleted) {
      final socket = await socketCompleter.future;
      await socket.close();
      socketCompleter = Completer();
    }
    final socket = await Socket.connect(localhost, port);
    socketCompleter.complete(socket);
    socket.listen((output) {
      final data = String.fromCharCodes(output).trim();
      _handleAction(
        Action.fromJson(
          json.decode(data),
        ),
      );
    });
  }

  _handleAction(Action action) {
    print(action);
    final completer = callbackCompleterMap[action.id];
    switch (action.method) {
      case ActionMethod.initClash:
      case ActionMethod.shutdown:
      case ActionMethod.getIsInit:
      case ActionMethod.startListener:
      case ActionMethod.resetTraffic:
      case ActionMethod.closeConnections:
      case ActionMethod.closeConnection:
        completer?.complete(action.data as bool);
        return;
      case ActionMethod.getProxies:
      case ActionMethod.changeProxy:
      case ActionMethod.getTraffic:
      case ActionMethod.getTotalTraffic:
      case ActionMethod.asyncTestDelay:
      case ActionMethod.getConnections:
      case ActionMethod.getExternalProviders:
      case ActionMethod.getExternalProvider:
      case ActionMethod.validateConfig:
      case ActionMethod.updateConfig:
      case ActionMethod.updateGeoData:
      case ActionMethod.updateExternalProvider:
      case ActionMethod.sideLoadExternalProvider:
        completer?.complete(action.data as String);
        return;
      case ActionMethod.message:
      case ActionMethod.forceGc:
      case ActionMethod.startLog:
      case ActionMethod.stopLog:
      case ActionMethod.stopListener:
      default:
        return;
    }
  }

  Future<T> _invoke<T>({
    required ActionMethod method,
    dynamic data,
  }) async {
    final id = "${method.name}#${other.id}";
    final socket = await socketCompleter.future;
    callbackCompleterMap[id] = Completer<T>();
    socket.writeln(
      json.encode(
        Action(
          id: id,
          method: method,
          data: data,
        ),
      ),
    );
    return (callbackCompleterMap[id] as Completer<T>).future;
  }

  _prueInvoke({
    required ActionMethod method,
    dynamic data,
  }) async {
    final id = "${method.name}#${other.id}";
    final socket = await socketCompleter.future;
    socket.writeln(
      json.encode(
        Action(
          id: id,
          method: method,
          data: data,
        ),
      ),
    );
  }

  @override
  Future<bool> init(String homeDir) {
    return _invoke<bool>(
      method: ActionMethod.initClash,
      data: homeDir,
    );
  }

  @override
  shutdown() async {
    final res = await _invoke<bool>(
      method: ActionMethod.shutdown,
    );
    if (!res) {
      return;
    }
    process.kill();
  }

  @override
  Future<bool> get isInit {
    return _invoke<bool>(
      method: ActionMethod.getIsInit,
    );
  }

  @override
  forceGc() {
    _prueInvoke(method: ActionMethod.forceGc);
  }

  @override
  FutureOr<String> validateConfig(String data) {
    return _invoke<String>(
      method: ActionMethod.validateConfig,
      data: data,
    );
  }

  @override
  FutureOr<String> updateConfig(UpdateConfigParams updateConfigParams) {
    return _invoke<String>(
      method: ActionMethod.updateConfig,
      data: json.encode(updateConfigParams),
    );
  }

  @override
  Future<String> getProxies() {
    return _invoke<String>(
      method: ActionMethod.getProxies,
    );
  }

  @override
  FutureOr<bool> changeProxy(ChangeProxyParams changeProxyParams) {
    return _invoke<bool>(
      method: ActionMethod.changeProxy,
      data: changeProxyParams,
    );
  }

  @override
  FutureOr<String> getExternalProviders() {
    return _invoke<String>(
      method: ActionMethod.getExternalProviders,
    );
  }

  @override
  FutureOr<String> getExternalProvider(String externalProviderName) {
    return _invoke<String>(
      method: ActionMethod.getExternalProvider,
      data: externalProviderName,
    );
  }

  @override
  Future<String> updateGeoData({
    required String geoType,
    required String geoName,
  }) {
    return _invoke<String>(
      method: ActionMethod.updateGeoData,
      data: {
        "geoType": geoType,
        "geoName": geoName,
      },
    );
  }

  @override
  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  }) {
    return _invoke<String>(
      method: ActionMethod.sideLoadExternalProvider,
      data: {
        "providerName": providerName,
        "data": data,
      },
    );
  }

  @override
  Future<String> updateExternalProvider({required String providerName}) {
    return _invoke<String>(
      method: ActionMethod.updateExternalProvider,
      data: providerName,
    );
  }

  @override
  FutureOr<String> getConnections() {
    return _invoke<String>(
      method: ActionMethod.getConnections,
    );
  }

  @override
  Future<bool> closeConnections() {
    return _invoke<bool>(
      method: ActionMethod.closeConnections,
    );
  }

  @override
  Future<bool> closeConnection(String id) {
    return _invoke<bool>(
      method: ActionMethod.closeConnection,
      data: id,
    );
  }

  @override
  FutureOr<String> getTotalTraffic() {
    return _invoke<String>(
      method: ActionMethod.getTotalTraffic,
    );
  }

  @override
  FutureOr<String> getTraffic() {
    return _invoke<String>(
      method: ActionMethod.getTraffic,
    );
  }

  @override
  resetTraffic() {
    _prueInvoke(method: ActionMethod.resetTraffic);
  }

  @override
  startLog() {
    _prueInvoke(method: ActionMethod.startLog);
  }

  @override
  stopLog() {
    _prueInvoke(method: ActionMethod.stopLog);
  }

  @override
  Future<bool> startListener() {
    return _invoke<bool>(
      method: ActionMethod.startListener,
    );
  }

  @override
  stopListener() {
    return _invoke<bool>(
      method: ActionMethod.stopListener,
    );
  }

  @override
  Future<String> asyncTestDelay(String proxyName) {
    return _invoke<String>(
      method: ActionMethod.asyncTestDelay,
      data: proxyName,
    );
  }
}

final clashService = system.isDesktop ? ClashService() : null;
