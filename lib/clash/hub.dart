import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/clash/interface.dart';
import 'package:path/path.dart';

import '../common/constant.dart';

class ClashHub with ClashInterface {
  static ClashHub? _instance;

  Completer<Socket> socketCompleter = Completer();

  factory ClashHub() {
    _instance ??= ClashHub._internal();
    return _instance!;
  }

  ClashHub._internal() {
    _initCore();
  }

  _initCore() async {
    String currentExecutablePath = Platform.resolvedExecutable;
    Directory currentDirectory = Directory(dirname(currentExecutablePath));
    final path = join(currentDirectory.path, "core");
    final process = await Process.start(path, []);
    process.stdout.listen((data) {
      final output = String.fromCharCodes(data).trim();
      if (output.startsWith("Port: ")) {
        final match = RegExp(r'\b\d+\b').firstMatch(output);
        if (match == null) {
          return;
        }
        final port = int.parse(match.group(0)!);
        _connectCore(port);
      }
    });
  }

  _connectCore(int port) async {
    final socket = await Socket.connect(localhost, port);
    socketCompleter.complete(socket);
    socket.listen((data) {});
  }

  @override
  Future<bool> init(String homeDir) async {
    final socket = await socketCompleter.future;
    socket.writeln(json.encode({
      "method": "initClash",
      "data": homeDir,
    }));
    return false;
  }
}
