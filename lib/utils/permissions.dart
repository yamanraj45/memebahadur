import "package:permission_handler/permission_handler.dart";

var permissions = [
  Permission.storage,
];

askPermissions() async {
  await permissions.request();
  while (!await isStoragePermissionGranted()) {
    // if (!await isStoragePermissionGranted()) {
    await askStoragePermission();
  }
  // }}
}

Future<bool> isStoragePermissionGranted() async {
  return await Permission.storage.isGranted;
}

askStoragePermission() async {
  await Permission.storage.request();
}
