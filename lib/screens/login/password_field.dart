import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true; // State for password visibility
  String _enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      style: AppTextStyles.authInputTextStyle(context),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        labelText: 'Lozinka',
        labelStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).textTheme.bodyMedium!.color!),
        ),
        // Suffix icon for showing/hiding password with animation
        suffixIcon: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _obscureText
                ? Icon(
                    Icons.visibility_off,
                    key: ValueKey<bool>(_obscureText),
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  )
                : Icon(
                    Icons.visibility,
                    key: ValueKey<bool>(_obscureText),
                    color: Theme.of(context).textTheme.bodyMedium?.color,
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
        if (value == null || value.trim().length < 6) {
          return 'Lozinka mora sadržavati najmanje 6 znakova';
        }
        return null;
      },
      onSaved: (value) {
        _enteredPassword = value!;
      },
    );
  }
}
