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

  get isAdmin async {
    if (!Platform.isWindows) return false;
    final result = await Process.run('net', ['session'], runInShell: true);
    return result.exitCode == 0;
  }

  Future<int> get version async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    return switch (Platform.operatingSystem) {
      "macos" => (deviceInfo as MacOsDeviceInfo).majorVersion,
      "android" => (deviceInfo as AndroidDeviceInfo).version.sdkInt,
      "windows" => (deviceInfo as WindowsDeviceInfo).majorVersion,
      String() => 0
    };
  }

  authorizeCore(String? password) async {
    final corePath = appPath.corePath.replaceAll(' ', '\\\\ ');
    if (Platform.isMacOS) {
      String shell = 'chown root:admin $corePath\nchmod +sx $corePath';
      String command = 'do shell script "$shell" with administrator privileges';
      await Process.run('osascript', ['-e', command]);
    }
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
