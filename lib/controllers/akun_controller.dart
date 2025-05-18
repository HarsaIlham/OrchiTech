import 'package:flutter/material.dart';
import 'package:orchitech/models/akun.dart';

class AkunController {
  Stream<Akun?> fetchProfile() {
    return Akun.getProfile();
  }

  Future<void> updateUserProfile({
    required String username,
    required String email,
    required BuildContext context,
  }) async {
    await Akun.updateProfile(
      username: username,
      email: email,
      context: context,
    );
  }

  Future<void> updateUserPassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    await Akun.updatePassword(
      newPassword: newPassword,
      context: context,
    );
  }

  Future<void> LoginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await Akun.login(
      email: email,
      password: password,
      context: context,
    );
  }

  Future<void> LogoutUser({required BuildContext context}) async {
    await Akun.logout(context: context);
  }
}