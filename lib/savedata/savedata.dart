import 'package:money_manager/savedata/types.dart';

import 'package:money_manager/savedata/native.dart'
    if (dart.library.html) 'package:money_manager/savedata/web.dart';

SaveData saveData = PlatformSaveData();
