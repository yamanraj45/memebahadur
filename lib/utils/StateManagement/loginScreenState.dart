import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logincheckProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());
final introbool = StateProvider<bool>((ref) => false);
final userProvider = StateProvider<User>((ref) {
  final user = ref.watch(logincheckProvider).data?.value;

  return user;
});
