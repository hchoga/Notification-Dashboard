import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_dashboard/features/auth/presentation/bloc/login_cubit.dart';

/// Reusable text field for login form
class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelKey;
  final String hintKey;
  final IconData prefixIcon;
  final bool obscureText;
  final VoidCallback? onPasswordVisibilityToggle;
  final bool showPasswordToggle;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.labelKey,
    required this.hintKey,
    required this.prefixIcon,
    this.obscureText = false,
    this.onPasswordVisibilityToggle,
    this.showPasswordToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return TextField(
          controller: controller,
          enabled: !isLoading,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintKey.tr(),
            labelText: labelKey.tr(),
            prefixIcon: Icon(prefixIcon),
            suffixIcon: showPasswordToggle
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: isLoading ? null : onPasswordVisibilityToggle,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
          ),
        );
      },
    );
  }
}
