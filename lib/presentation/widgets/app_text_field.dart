import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final Color? iconColor;
  final void Function()? onClickIcon;
  final void Function()? onTap;
  final bool? obscureText;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;

  const AppTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.icon,
    this.iconColor,
    this.onClickIcon,
    this.onTap,
    this.obscureText,
    required this.controller,
    this.validator,
    required this.title,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: TextFormField(
        enabled: enabled,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5)),
          hintText: hintText,
          hintStyle: theme.textTheme.bodySmall,
          labelText: title,
          floatingLabelStyle: theme.textTheme.bodyMedium,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(10),
          suffixText: suffixText,
          suffixStyle: const TextStyle(color: Colors.red),
          suffixIcon: GestureDetector(onTap: onClickIcon, child: Icon(icon, color: iconColor)),
        ),
        style: theme.textTheme.bodyMedium,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
