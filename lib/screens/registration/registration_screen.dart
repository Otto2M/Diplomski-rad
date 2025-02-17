import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/screens/login/login_screen.dart';
import 'package:povedi_me_app/screens/registration/registration_screen_success.dart';
import 'package:povedi_me_app/screens/registration/registration_text_field.dart';
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
  bool isLoading = false;

  void _submit() async {
    final isValid = _registrationFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _registrationFormKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    try {
      await firebaseAuth.signUp(
        email: _enteredEmail,
        password: _enteredPassword,
        username: _enteredUsername,
        name: _enteredName,
        phoneNumber: _enteredPhoneNumber,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RegistrationScreenSuccess(),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(error.toString())),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
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

  bool _isValidName(String name) {
    final nameRegex = RegExp(r'^[A-Za-zČčĆćŠšŽžĐđ ]+$');
    return nameRegex.hasMatch(name);
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    Assets.iPerson,
                    scale: MediaQuery.of(context).size.aspectRatio * 15,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "REGISTRACIJA",
                    style: AppTextStyles.authHeadline(context),
                  ),
                  const SizedBox(height: 20),

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
                            CustomTextField(
                              label: 'Ime i prezime',
                              imgAssets: Assets.iPerson,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Ovo polje je obavezno!';
                                }
                                if (!_isValidName(value)) {
                                  return 'Neispravan format imena!';
                                }
                                return null;
                              },
                              onSaved: (value) => _enteredName = value!,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Korisničko ime',
                              imgAssets: Assets.iPersonBorder,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Molimo Vas da unesete željeno korisničko ime';
                                }
                                return null;
                              },
                              onSaved: (value) => _enteredUsername = value!,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Broj mobitela',
                              imgAssets: Assets.iPhone,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Molimo Vas da unesete broj mobitela.';
                                }
                                if (!_isValidPhoneNumber(value)) {
                                  return 'Neispravan format broja mobitela.';
                                }
                                return null;
                              },
                              onSaved: (value) => _enteredPhoneNumber = value!,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Email',
                              imgAssets: Assets.iEmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@') ||
                                    !_isValidEmail(value)) {
                                  return 'Neispravan format email adrese.';
                                }
                                return null;
                              },
                              onSaved: (value) => _enteredEmail = value!,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Lozinka',
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Lozinka mora sadržavati najmanje 6 znakova';
                                }
                                return null;
                              },
                              onSaved: (value) => _enteredPassword = value!,
                            ),
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
                              'REGISTRIRAJ SE',
                              style: AppTextStyles.authButtonTextStyle(context),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Text(
                      'Već imam korisnički račun...',
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

                  SignInButton(
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
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Uspješna prijava Vašim Google računom!'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Sign-in failed: $e')),
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
