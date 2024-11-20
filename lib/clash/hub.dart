import 'package:fl_clash/clash/interface.dart';

class ClashHub with ClashInterface {
  static ClashHub? _instance;

  factory ClashHub() {
    _instance ??= ClashHub._internal();
    return _instance!;
  }

  ClashHub._internal();

  @override
  bool init(String homeDir) {
    return false;
  }
}
