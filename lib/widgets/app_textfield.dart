import 'package:flutter/material.dart';
import 'package:hr_application/utils/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;
  final String? Function(String? val)? validator;

  const AppTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.controller,
    this.margin,
    this.validator,
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
        validator: widget.validator,
        controller: widget.controller,
        key: widget.key,
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
