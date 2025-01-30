import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/screens/login/login_screen.dart';
import 'package:povedi_me_app/screens/registration/registration_screen_success.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registrationFormKey = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredUsername = '';
  var _enteredPhoneNumber = '';
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _registrationFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _registrationFormKey.currentState!.save();

    firebaseAuth.signUp(
      email: _enteredEmail,
      password: _enteredPassword,
      username: _enteredUsername,
      name: _enteredName,
      phoneNumber: _enteredPhoneNumber,
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const RegistrationScreenSuccess(),
      ),
      (route) => false,
    );
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
                    "REGISTRACIJA",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.person,
                    size: 150,
                    color: AppColors.darkBlue,
                  ),
                  const SizedBox(height: 30),

                  //forma za REGISTRACIJU
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _registrationFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Name
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person,
                                    color: AppColors.darkBlue),
                                labelText: 'Ime i prezime',
                                labelStyle:
                                    const TextStyle(color: AppColors.darkBlue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.darkBlue),
                                ),
                              ),
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Molimo Vas da unesete ispravni format imena i prezimena';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredName = value!;
                              },
                            ),
                            const SizedBox(height: 20),

                            //Username
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: AppColors.darkBlue),
                                labelText: 'Korisničko ime',
                                labelStyle:
                                    const TextStyle(color: AppColors.darkBlue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.darkBlue),
                                ),
                              ),
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Molimo Vas da unesete željeno korisničko ime';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                            const SizedBox(height: 20),

                            //Phone number
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone,
                                    color: AppColors.darkBlue),
                                labelText: 'Broj mobitela',
                                labelStyle:
                                    const TextStyle(color: AppColors.darkBlue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.darkBlue),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.contains(RegExp(','))) {
                                  return 'Molimo Vas da unesete broj mobitela';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPhoneNumber = value!;
                              },
                            ),
                            const SizedBox(height: 20),

                            //E-mail
                            TextFormField(
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
                  const SizedBox(height: 30),

                  //button za registraciju
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
                        'REGISTRIRAJ SE',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: const Text('Već imam korisnički račun...'),
                  ),

                  const SizedBox(height: 30),

                  const Divider(
                    color: AppColors.darkBlue,
                  ),
                  SignInButton(
                    Buttons.google,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),

                  const SizedBox(height: 10),

                  SignInButtonBuilder(
                    text: 'Prijavi se putem Google',
                    icon: Icons.email,
                    onPressed: () async {
                      try {
                        // setState(() {
                        //   isLoading = true;
                        // });
                        await firebaseAuth.signInWithGoogle();
                        // setState(() {
                        //   isLoading = false;
                        // });
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Uspješno prijavljeno!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Sign-in failed: $e')),
                        );
                      }
                    },
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
