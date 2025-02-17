import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    this.imgAssets,
    this.isObscure = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    super.key,
  });

  final String label;
  final String? imgAssets;
  final bool isObscure;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && _obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.isPassword
            ? Icon(
                Icons.lock,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              )
            : Image.asset(
                widget.imgAssets!,
                scale: 40,
                width: 10,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
        labelText: widget.label,
        labelStyle: AppTextStyles.authLabelTextStyle(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(
                  () => _obscureText = !_obscureText,
                ),
              )
            : null,
      ),
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      style: AppTextStyles.authInputTextStyle(context),
    );
  }
}
