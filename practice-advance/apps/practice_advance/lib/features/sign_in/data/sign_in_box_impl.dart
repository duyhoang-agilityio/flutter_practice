import 'package:isar/isar.dart';
import 'package:practice_advance/features/sign_in/domain/entities/user.dart';

class SignInBoxImpl extends SignInBox {
  final Isar isar;

  SignInBoxImpl(this.isar);

  @override
  Future<User?> getUser() async {
    return isar.users.get(1);
  }

  @override
  Future<void> removeUser() async {
    await isar.writeTxn(() async {
      await isar.users.clear(); // Remove all stored users
    });
  }

  @override
  Future<void> saveUser({required User user}) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }
}

abstract class SignInBox {
  Future<void> saveUser({required User user});
  Future<User?> getUser();
  Future<void> removeUser();
}
