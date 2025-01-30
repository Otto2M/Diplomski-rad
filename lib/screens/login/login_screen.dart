import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/screens/home/demo/demo_home_screen.dart';
import 'package:povedi_me_app/screens/registration/registration_screen.dart';
//import 'package:povedi_me_app/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:povedi_me_app/constants/instances.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  bool isLoading = false;

  void _submit() async {
    final isValid = _loginFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _loginFormKey.currentState!.save();

    await firebaseAuth.signInUser(_enteredEmail, _enteredPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //text i ikona na početku
                  const Text(
                    "PRIJAVA",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.person,
                    size: 200,
                    color: AppColors.darkBlue,
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
                                prefixIcon: const Icon(Icons.email,
                                    color: AppColors.darkBlue),
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: AppColors.darkBlue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.darkBlue),
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
                            ),

                            const SizedBox(height: 20),

                            //Password
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock,
                                    color: AppColors.darkBlue),
                                labelText: 'Lozinka',
                                labelStyle:
                                    const TextStyle(color: AppColors.darkBlue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.darkBlue),
                                ),
                                // focusedBorder: const UnderlineInputBorder(
                                //   borderSide: BorderSide(
                                //       color: AppColors.accentLight, width: 3.0),
                                // ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Lozinka mora sadržavati najmanje 6 znakova';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  //button za prijavu
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text(
                        'PRIJAVI SE',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),

                  //button za odlazak na registraciju
                  TextButton(
                    //onPressed: () {},
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    ),
                    child: const Text('Kreiraj novi korisnički račun'),
                  ),
                  const SizedBox(height: 10),

                  const Divider(
                    color: AppColors.darkBlue,
                  ),

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
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Google Sign-in failed: $e')),
                              );
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
      ),
    );
  }
}
