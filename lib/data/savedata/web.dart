import 'dart:convert';
import 'dart:html';

import 'package:money_manager/types/savedata.dart';

class PlatformSaveData extends SaveData {
  @override
  Future<void> write(ConfigModel settings) async {
    window.localStorage['config'] = jsonEncode(settings.toObj());
  }

  @override
  Future<ConfigModel> read() async {
    return ConfigModel.fromObj(jsonDecode(
        window.localStorage['config'] ?? SaveData.defaultSaveDataString));
  }
}
