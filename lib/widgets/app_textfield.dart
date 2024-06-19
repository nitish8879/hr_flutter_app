import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_application/utils/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;
  final String? Function(String? val)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.controller,
    this.margin,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        validator: widget.validator,
        controller: widget.controller,
        key: widget.key,
        onChanged: widget.onChanged,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: AppColors.kGrey100,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
