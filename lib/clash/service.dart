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
    final process = await Process.start(path, []);
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
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> init(String homeDir) async {
    final socket = await socketCompleter.future;
    socket.writeln(
      Action(
        method: ActionMethod.initClash,
        data: homeDir,
      ).toJson(),
    );
    _initClashCompleter = Completer();
    return _initClashCompleter!.future;
  }
}

final clashService = ClashService();
