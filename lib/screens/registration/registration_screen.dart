import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/screens/login/login_screen.dart';

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

  void _submit() {
    final isValid = _registrationFormKey.currentState!.validate();

    if (isValid) {
      _registrationFormKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
      print(_enteredName);
      print(_enteredUsername);
      print(_enteredPhoneNumber);
    }
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
                    color: AppColors.accentLight,
                  ),
                  SizedBox(height: 30),

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
                                    color: AppColors.accentLight),
                                labelText: 'Ime i prezime',
                                labelStyle: const TextStyle(
                                    color: AppColors.accentLight),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.accentLight),
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
                            SizedBox(height: 20),

                            //Username
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: AppColors.accentLight),
                                labelText: 'Korisničko ime',
                                labelStyle: const TextStyle(
                                    color: AppColors.accentLight),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.accentLight),
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
                            SizedBox(height: 20),

                            //Phone number
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone,
                                    color: AppColors.accentLight),
                                labelText: 'Broj mobitela',
                                labelStyle: const TextStyle(
                                    color: AppColors.accentLight),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.accentLight),
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
                            SizedBox(height: 20),

                            //E-mail
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email,
                                    color: AppColors.accentLight),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                    color: AppColors.accentLight),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.accentLight),
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

                            SizedBox(height: 20),

                            //Password
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock,
                                    color: AppColors.accentLight),
                                labelText: 'Lozinka',
                                labelStyle: const TextStyle(
                                    color: AppColors.accentLight),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.accentLight),
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
                  SizedBox(height: 30),

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
                          color: AppColors.accentLight,
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
                      child: const Text('Već imam korisnički račun...')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
