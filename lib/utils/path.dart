import 'dart:io';

import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:flutter/services.dart';

final String dataDirName = "memebahadur";

class PathUtils {
  static Future<String> getRootDirString() async {
    String dir;
    try {
      var storageInfo = await PathProviderEx.getStorageInfo();
      if (storageInfo.length > 0) {
        dir = storageInfo[0].rootDir;
      }
    } on PlatformException {
      dir = null;
    }
    return dir;
  }

  static Future<Directory> getRootDir() async {
    final String rootDirString = await getRootDirString();
    return Directory(rootDirString);
  }

  static Future<Directory> getDataDir() async {
    final String rootDirString = await getRootDirString();
    return await Directory("$rootDirString/$dataDirName")
        .create(recursive: true);
  }
}
