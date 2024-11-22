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
      print(output);
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
    socketCompleter.complete(Socket.connect(localhost, port));
  }

  get socket async => socketCompleter.future;

  @override
  bool init(String homeDir) {
    socketCompleter.future.then((socket) async {
      socket.writeln(json.encode(
        {
          "method": "initClash",
          "data": "123",
        },
      ));
    });
    return false;
  }
}
