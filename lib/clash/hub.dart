import 'dart:io';

import 'package:fl_clash/clash/interface.dart';
import 'package:path/path.dart';

class ClashHub with ClashInterface {
  static ClashHub? _instance;

  factory ClashHub() {
    _instance ??= ClashHub._internal();
    String currentExecutablePath = Platform.resolvedExecutable;
    Directory currentDirectory = Directory(dirname(currentExecutablePath));
    var path = join(currentDirectory.path, "core");
    Process.start(path, []).then((process) {
      process.stdout.listen((data) {
        print(String.fromCharCodes(data));
      });
    });
    return _instance!;
  }

  ClashHub._internal();

  @override
  bool init(String homeDir) {
    return false;
  }
}
