import 'dart:ffi';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:daily_quote/home/home_view.dart';
import 'package:daily_quote/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final ok = await AuthService().login(_email.text.trim(), _password.text);
    setState(() => _loading = false);

    if (!ok) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
      return;
    }

    final preference = await SharedPreferences.getInstance();
    await preference.setBool('is_logged_in', true);
    await preference.setString('email', _email.text.trim());

    if (!mounted) return;
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFEEBF6),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/logo 960 frame.png'),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (valid) {
                      if (valid == null || valid.trim().isEmpty)
                        return 'Email wajib diisi';
                      if (!valid.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (valid) {
                      if (valid == null || valid.trim().isEmpty)
                        return 'Password wajib diisi';
                      if (valid.length < 6)
                        return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF687FE5),
                      ),
                      onPressed:
                          _loading
                              ? null
                              : () {
                                AwesomeDialog(
                                  context: context,
                                  customHeader: Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.greenAccent,
                                    size: 55,
                                  ),
                                  dialogType: DialogType.success,
                                  animType: AnimType.bottomSlide,
                                  title: 'Login Sukses',
                                  autoHide: Duration(milliseconds: 1000),
                                ).show();
                              },
                      child:
                          _loading
                              ? const CircularProgressIndicator()
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
