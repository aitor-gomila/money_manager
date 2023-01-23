import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:money_manager/types/savedata.dart';

class PlatformSaveData extends SaveData {
  Future<String> getPathToSaveData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return join(directory.path, "finances.json");
  }

  Future<void> nullCheckSaveFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "finances.json");
    File file = File(path);
    if (!await file.exists()) {
      await file.writeAsString(SaveData.defaultSaveDataString);
      return;
    }
    try {
      jsonDecode(await file.readAsString());
    } catch (e) {
      await file.writeAsString(SaveData.defaultSaveDataString);
    }
  }

  @override
  Future<void> write(ConfigModel settings) async {
    File file = File(await getPathToSaveData());
    await file.writeAsString(jsonEncode(settings.toObj()));
  }

  @override
  Future<ConfigModel> read() async {
    await nullCheckSaveFile();
    File file = File(await getPathToSaveData());
    String plainText = await file.readAsString();
    return ConfigModel.fromObj(jsonDecode(plainText));
  }
}
