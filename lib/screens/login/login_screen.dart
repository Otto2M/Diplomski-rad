import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/providers/auth_user_state_provider.dart';
import 'package:povedi_me_app/screens/login/password_field.dart';
import 'package:povedi_me_app/screens/registration/registration_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';
//import 'package:povedi_me_app/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:povedi_me_app/constants/instances.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  bool isLoading = false;
  bool _obscureText = true;

  void _submit() async {
    final isValid = _loginFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _loginFormKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    try {
      await firebaseAuth.signInUser(_enteredEmail, _enteredPassword);

      // Ne treba ručno navigirati jer authStateProvider osluškuje promjene
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Prijava nije uspjela: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(
          () {
            isLoading = false;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider).value;

    if (authState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const TabScreen()),
          );
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //text i ikona na početku
                      Text(
                        "PRIJAVA",
                        style: AppTextStyles.authHeadline(context),
                      ),
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
                                TextFormField(
                                  //controller: ,
                                  decoration: InputDecoration(
                                    prefixIcon: Image.asset(
                                      Assets.iEmail,
                                      scale: 40,
                                      width: 10,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color,
                                    ),
                                    labelText: 'Email',
                                    labelStyle:
                                        AppTextStyles.authLabelTextStyle(
                                      context,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.none,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredEmail = value!;
                                  },
                                  style:
                                      AppTextStyles.authInputTextStyle(context),
                                ),

                                const SizedBox(height: 20),

                                TextFormField(
                                  obscureText: _obscureText,
                                  style:
                                      AppTextStyles.authInputTextStyle(context),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                    ),
                                    labelText: 'Lozinka',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color!),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: _obscureText
                                            ? Icon(
                                                Icons.visibility_off,
                                                key: ValueKey<bool>(
                                                    _obscureText),
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                key: ValueKey<bool>(
                                                    _obscureText),
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                              ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Lozinka mora sadržavati najmanje 6 znakova';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredPassword = value!;
                                  },
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
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
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
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => HomeScreen()));
                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const HomeScreen()),
                                  //   (route) => false,
                                  // );
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Google Sign-in failed: $e'),
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
