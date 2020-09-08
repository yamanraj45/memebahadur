import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:memebahadur/utils/permissions.dart';
import 'package:memebahadur/utils/path.dart';
import 'dialogs.dart';

takeScreenshot(GlobalKey previewContainer) async {
  String filename = DateTime.now().millisecondsSinceEpoch.toString();
  Directory rootDir = await PathUtils.getDataDir();
  // String rootPath = rootDir.path;
  RenderRepaintBoundary boundary =
      previewContainer.currentContext.findRenderObject();
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();
  return await ImageGallerySaver.saveImage(pngBytes, name: "$filename")
      .then((value) {
    print("Saved");
    return filename = "${rootDir.path}/$filename.jpg";
  });
}

void onSavePress(
  BuildContext context,
  GlobalKey key, {
  showDialog = true,
}) async {
  bool status = await isStoragePermissionGranted();
  if (status) {
    takeScreenshot(key);
    if (showDialog) {
      showSavingDialog(context);
    }
  } else {
    showFailedDialog(context, "No storage Permission");
    await askStoragePermission();
  }
}

void onBackPress(BuildContext context, {bool flag = false}) {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  if (flag) {
    showExitDialog(context);
  } else {
    Navigator.of(context).pop();
  }
}
