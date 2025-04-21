import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authSvc = AuthService();
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();

  bool _signUp = false; // false = Login, true = Sign‑up
  bool _loading = false;

  /* --Google -- */
  Future<void> _google() async {
    await _run(() => _authSvc.signInWithGoogle());
  }

  /* -- Email/ Password -- */
  Future<void> _emailAuth() async {
    if (_form.currentState?.validate() != true) return;

    if (FirebaseAuth.instance.currentUser != null) {
      await _authSvc.signOut();
    }

    await _run(() async {
      if (_signUp) {
        await _authSvc.registerWithEmail(
            email: _email.text.trim(), pwd: _pwd.text.trim());
      } else {
        await _authSvc.signInWithEmail(
            email: _email.text.trim(), pwd: _pwd.text.trim());
      }
    });
  }

  Future<void> _run(Future<void> Function() task) async {
    setState(() => _loading = true);
    try {
      await task();
    } on FirebaseAuthException catch (e) {
      _snack('[${e.code}] ${e.message ?? ''}');
    } catch (e) {
      _snack('$e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const FlutterLogo(size: 100),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
                onPressed: _loading ? null : _google,
              ),
              const Divider(height: 40, thickness: 1),
              Form(
                key: _form,
                child: Column(children: [
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) =>
                        v!.contains('@') ? null : 'Enter valid email',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pwd,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (v) =>
                        v!.length >= 6 ? null : 'Min 6 characters',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _loading ? null : _emailAuth,
                    child: Text(_signUp ? 'Sign up' : 'Login'),
                  ),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () => setState(() => _signUp = !_signUp),
                    child: Text(_signUp
                        ? 'Have an account? Login'
                        : 'No account? Sign up'),
                  ),
                ]),
              ),
              if (_loading)
                const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: CircularProgressIndicator()),
            ]),
          ),
        ),
      );
}
