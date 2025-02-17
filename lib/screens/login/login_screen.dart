import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/text.dart';
import 'package:povedi_me_app/screens/login/auth_controller.dart';
import 'package:povedi_me_app/screens/login/auth_text_field.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/screens/registration/registration_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';
import 'package:povedi_me_app/constants/instances.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _authController = AuthController(firebaseAuth);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _emailError = false;
  bool _passwordError = false;
  bool isLoading = false;

  void _submit() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      _emailError = false;
      _passwordError = false;
    });

    _loginFormKey.currentState!.save();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    await _authController.signIn(
      email,
      password,
      onSuccess: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabScreen(),
          ),
        );
      },
      onError: (error) {
        setState(() {
          _errorMessage = error;
          _emailError = true;
          _passwordError = true;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //text i ikona na početku
                Text("PRIJAVA", style: AppTextStyles.authHeadline(context)),
                const SizedBox(height: 20),
                Image.asset(
                  Assets.iPerson,
                  scale: MediaQuery.of(context).size.aspectRatio * 10,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                const SizedBox(height: 50),

                //forma za prijavu
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //E-mail
                          AuthTextField(
                            label: TextConstant.emailLabel,
                            controller: _emailController,
                            imgIcon: Assets.iEmail,
                            isEmailError: _emailError,
                          ),
                          const SizedBox(height: 20),
                          AuthTextField(
                            label: TextConstant.passwordLabel,
                            controller: _passwordController,
                            isPassword: true,
                            isPasswordError: _passwordError,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                //button za prijavu
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'PRIJAVI SE',
                            style: AppTextStyles.authButtonTextStyle(context),
                          ),
                  ),
                ),

                //button za odlazak na registraciju
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  ),
                  child: Text(
                    'Kreiraj novi korisnički račun',
                    style: AppTextStyles.authTextBtnStyle(context),
                  ),
                ),
                const SizedBox(height: 10),

                Divider(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  indent: 20,
                  endIndent: 20,
                  thickness: 2,
                ),
                const SizedBox(height: 20),

                //google sign in button
                isLoading
                    ? const CircularProgressIndicator()
                    : SignInButton(
                        Buttons.google,
                        onPressed: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await firebaseAuth.signInWithGoogle();
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const TabScreen()));
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Google Sign-in failed: $e'),
                                ),
                              );
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
