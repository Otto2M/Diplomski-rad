import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/constants/text.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.imgIcon,
    this.isEmailError = false,
    this.isPasswordError = false,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? imgIcon;
  final bool isEmailError;
  final bool isPasswordError;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      style: AppTextStyles.authInputTextStyle(context),
      decoration: InputDecoration(
        prefixIcon: widget.isPassword
            ? Icon(
                Icons.lock,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              )
            : Image.asset(
                widget.imgIcon!,
                scale: 40,
                width: 10,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
        labelText: widget.label,
        labelStyle: AppTextStyles.authLabelTextStyle(context),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(
                  () => _obscureText = !_obscureText,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).textTheme.bodyMedium!.color!),
        ),
        filled: true,
        fillColor: (widget.isPasswordError || widget.isEmailError)
            ? Theme.of(context).textTheme.titleSmall!.color
            : Colors.transparent,
      ),
      keyboardType:
          !widget.isPassword ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.label} je obavezno polje';
        }
        if (widget.label == TextConstant.emailLabel && !value.contains('@')) {
          return 'Neispravna email adresa';
        }
        if (widget.label == TextConstant.passwordLabel && value.length < 6) {
          return 'Lozinka mora imati najmanje 6 znakova';
        }
        return null;
      },
    );
  }
}
