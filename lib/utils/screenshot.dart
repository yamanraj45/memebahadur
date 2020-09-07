import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:memebahadur/utils/permissions.dart';

import 'dialogs.dart';

takeScreenshot(GlobalKey previewContainer) async {
  RenderRepaintBoundary boundary =
      previewContainer.currentContext.findRenderObject();
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();
  ImageGallerySaver.saveImage(pngBytes).then((value) => print("Saved"));
}

void onSavePress(BuildContext context, GlobalKey key) async {
  bool status = await isStoragePermissionGranted();
  if (status) {
    takeScreenshot(key);
    showSavingDialog(context);
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
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
}
