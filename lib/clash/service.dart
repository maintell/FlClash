import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/clash/interface.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/core.dart';
import 'package:path/path.dart';

import '../common/constant.dart';

class ClashService with ClashInterface {
  static ClashService? _instance;

  Completer<Socket> socketCompleter = Completer();

  Completer<bool>? _initClashCompleter;

  Completer<bool>? _shutdownCompleter;

  Completer<bool>? _getIsInitCompleter;

  Completer<String>? _validateConfigCompleter;

  Completer<String>? _updateConfigCompleter;

  Completer<String>? _getProxiesCompleter;

  Completer<bool>? _changeProxyCompleter;

  Completer<String>? _getExternalProvidersCompleter;

  Completer<String>? _getExternalProviderCompleter;

  Completer<String>? _updateGeoDataCompleter;

  Completer<String>? _sideLoadExternalProviderCompleter;

  Completer<String>? _updateExternalProviderCompleter;

  late final Process process;

  factory ClashService() {
    _instance ??= ClashService._internal();
    return _instance!;
  }

  ClashService._internal() {
    _initCore();
  }

  _initCore() async {
    String currentExecutablePath = Platform.resolvedExecutable;
    Directory currentDirectory = Directory(dirname(currentExecutablePath));
    final path = join(currentDirectory.path, "core");
    process = await Process.start(path, []);
    final port = int.parse(
      String.fromCharCodes(await process.stdout.first).trim(),
    );
    _connectCore(port);
  }

  _connectCore(int port) async {
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
    switch (action.method) {
      case ActionMethod.initClash:
        _initClashCompleter?.complete(action.data as bool);
        return;
      case ActionMethod.shutdown:
        _shutdownCompleter?.complete(action.data as bool);
        return;
      case ActionMethod.getIsInit:
        _getIsInitCompleter?.complete(action.data as bool);
        return;
      case ActionMethod.validateConfig:
        _validateConfigCompleter?.complete(action.data as String);
        return;
      default:
        return;
    }
  }

  Future<T> _invoke<T>({
    required ActionMethod method,
    dynamic data,
    required Completer<T> completer,
  }) async {
    final socket = await socketCompleter.future;
    socket.writeln(
      Action(
        method: method,
        data: data,
      ).toJson(),
    );
    return completer.future;
  }

  _prueInvoke({
    required ActionMethod method,
    dynamic data,
  }) async {
    final socket = await socketCompleter.future;
    socket.writeln(
      Action(
        method: method,
        data: data,
      ).toJson(),
    );
  }

  @override
  Future<bool> init(String homeDir) {
    _initClashCompleter = Completer();
    return _invoke<bool>(
      method: ActionMethod.initClash,
      data: homeDir,
      completer: _initClashCompleter!,
    );
  }

  @override
  shutdown() async {
    _shutdownCompleter = Completer();
    final res = await _invoke<bool>(
      method: ActionMethod.shutdown,
      completer: _shutdownCompleter!,
    );
    if (!res) {
      return;
    }
    process.kill();
  }

  @override
  Future<bool> get isInit {
    _getIsInitCompleter = Completer();
    return _invoke<bool>(
      method: ActionMethod.getIsInit,
      completer: _getIsInitCompleter!,
    );
  }

  @override
  forceGc() {
    _prueInvoke(method: ActionMethod.forceGc);
  }

  @override
  FutureOr<String> validateConfig(String data) {
    _validateConfigCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.validateConfig,
      data: data,
      completer: _validateConfigCompleter!,
    );
  }

  @override
  FutureOr<String> updateConfig(UpdateConfigParams updateConfigParams) {
    _updateConfigCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.updateConfig,
      data: updateConfigParams,
      completer: _updateConfigCompleter!,
    );
  }

  @override
  Future<String> getProxies() {
    _getProxiesCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.getProxies,
      completer: _getProxiesCompleter!,
    );
  }

  @override
  FutureOr<bool> changeProxy(ChangeProxyParams changeProxyParams) {
    _changeProxyCompleter = Completer();
    return _invoke<bool>(
      method: ActionMethod.changeProxy,
      data: changeProxyParams,
      completer: _changeProxyCompleter!,
    );
  }

  @override
  FutureOr<String> getExternalProviders() {
    _getExternalProvidersCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.getExternalProviders,
      completer: _getExternalProvidersCompleter!,
    );
  }

  @override
  FutureOr<String> getExternalProvider(String externalProviderName) {
    _getExternalProviderCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.getExternalProvider,
      data: externalProviderName,
      completer: _getExternalProviderCompleter!,
    );
  }

  @override
  Future<String> updateGeoData({
    required String geoType,
    required String geoName,
  }) {
    _updateGeoDataCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.updateGeoData,
      data: {
        "geoType": geoType,
        "geoName": geoName,
      },
      completer: _updateGeoDataCompleter!,
    );
  }

  @override
  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  }) {
    _sideLoadExternalProviderCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.sideLoadExternalProvider,
      data: {
        "providerName": providerName,
        "data": data,
      },
      completer: _sideLoadExternalProviderCompleter!,
    );
  }

  @override
  Future<String> updateExternalProvider({required String providerName}) {
    _updateExternalProviderCompleter = Completer();
    return _invoke<String>(
      method: ActionMethod.updateExternalProvider,
      data: providerName,
      completer: _updateExternalProviderCompleter!,
    );
  }
}

final clashService = ClashService();
