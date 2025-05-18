import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orchitech/views/pages/login_page.dart';
import 'package:orchitech/views/pages/main_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Akun {
  final int idAkun;
  final String email;
  final String password;
  final String username;
  final int statusAkun;

  static final supabase = Supabase.instance.client;
  static final _storage = FlutterSecureStorage();

  Akun({
    required this.idAkun,
    required this.email,
    required this.password,
    required this.username,
    required this.statusAkun,
  });

  factory Akun.fromJson(Map<String, dynamic> json) => Akun(
        idAkun: json['id_akun'],
        email: json['email'],
        password: json['password'],
        username: json['username'],
        statusAkun: json['status_akun'],
      );

  Map<String, dynamic> toJson() => {
        'id_akun': idAkun,
        'email': email,
        'password': password,
        'username': username,
        'status_akun': statusAkun,
      };

  static Stream<Akun?> getProfile() async* {
    try {
      final userId = await _storage.read(key: 'user_id');
      if (userId != null) {
        final response = await supabase
            .from('akun')
            .select()
            .eq('id_akun', userId)
            .maybeSingle();
        if (response != null) {
          yield Akun.fromJson(response);
        }
        yield* supabase
            .from('akun')
            .stream(primaryKey: ['id_akun'])
            .map((rows) => rows.isNotEmpty ? Akun.fromJson(rows.first) : null);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateProfile({
    required String username,
    required String email,
    required BuildContext context,
  }) async {
    try {
      final userId = await _storage.read(key: 'user_id');
      if (userId != null) {
        await supabase
            .from('akun')
            .update({'username': username, 'email': email})
            .eq('id_akun', userId);
        await _storage.write(key: 'user_email', value: email);
        _showSuccess(context, 'Profil berhasil diperbarui.');
      } else {
        _showError(context, 'Profil gagal diperbarui.');
      }
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  static Future<void> updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      final userId = await _storage.read(key: 'user_id');
      if (userId != null) {
        await supabase
            .from('akun')
            .update({'password': newPassword})
            .eq('id_akun', userId);
        _showSuccess(context, 'Password berhasil diperbarui.');
      } else {
        _showError(context, 'Password gagal diperbarui.');
      }
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response =
          await supabase
              .from('akun')
              .select('id_akun, email, password')
              .eq('email', email)
              .single();

      if (response.isEmpty) {
        // ignore: use_build_context_synchronously
        _showError(context, 'Akun tidak ditemukan.');
      }

      // Cek password (disarankan untuk menggunakan hash di produksi)
      if (response['password'] != password) {
        // ignore: use_build_context_synchronously
        _showError(context, 'Password salah.');
      } else {
        await _storage.write(
          key: 'user_id',
          value: response['id_akun'].toString(),
        );
        await _storage.write(key: 'user_email', value: response['email']);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainPage.routeName,
          (route) => false,
        );
      } // ignore: use_build_context_synchronously
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError(context, 'Email atau password anda salah');
    }
  }

  static Future<void> logout({required BuildContext context}) async {
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'user_email');
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
    _showSuccess(context, 'Berhasil logout.');
  }

  static void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromRGBO(3, 68, 45, 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
