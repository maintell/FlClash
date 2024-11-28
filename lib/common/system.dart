import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:flutter/services.dart';

class System {
  static System? _instance;

  System._internal();

  factory System() {
    _instance ??= System._internal();
    return _instance!;
  }

  bool get isDesktop =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  Future<int> get version async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    return switch (Platform.operatingSystem) {
      "macos" => (deviceInfo as MacOsDeviceInfo).majorVersion,
      "android" => (deviceInfo as AndroidDeviceInfo).version.sdkInt,
      "windows" => (deviceInfo as WindowsDeviceInfo).majorVersion,
      String() => 0
    };
  }

  Future<bool> checkIsAdmin(String path) async {
    if (Platform.isMacOS) {
      final result = await Process.run('stat', ['-f', '%Su:%Sg %Lp', path]);
      final output = result.stdout.trim();
      print(output);
      if (output.startsWith('root:admin') && output.contains('s')) {
        return true;
      }
      return false;
    }
    return true;
  }

  Future<bool> authorizeCore({
    String? password,
  }) async {
    final corePath = appPath.corePath.replaceAll(' ', '\\\\ ');
    final isAdmin = await checkIsAdmin(corePath);
    if (isAdmin) {
      return false;
    }
    if (Platform.isMacOS) {
      final shell = 'chown root:admin $corePath; chmod +sx $corePath';
      final arguments = [
        "-e",
        'do shell script "$shell" with administrator privileges',
      ];
      await Process.run("osascript", arguments);
      return true;
    }
    return false;
  }

  back() async {
    await app?.moveTaskToBack();
    await window?.hide();
  }

  exit() async {
    if (Platform.isAndroid) {
      await SystemNavigator.pop();
    }
    await window?.close();
  }
}

final system = System();
