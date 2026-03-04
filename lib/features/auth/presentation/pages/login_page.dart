import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_dashboard/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notification_dashboard/features/auth/domain/usecases/login_usecase.dart';
import 'package:notification_dashboard/features/auth/presentation/bloc/login_cubit.dart';
import 'package:notification_dashboard/features/auth/presentation/widgets/language_button.dart';
import 'package:notification_dashboard/features/auth/presentation/widgets/login_button.dart';
import 'package:notification_dashboard/features/auth/presentation/widgets/login_error_widget.dart';
import 'package:notification_dashboard/features/auth/presentation/widgets/login_header.dart';
import 'package:notification_dashboard/features/auth/presentation/widgets/login_text_field.dart';
import 'package:notification_dashboard/features/notifications/presentation/bloc/notification_cubit.dart';
import 'package:notification_dashboard/features/notifications/presentation/pages/dashboard_page.dart';
import 'package:notification_dashboard/generated/locale_keys.g.dart';
import 'package:notification_dashboard/service_locator.dart';

/// Login Page - User authentication
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  // Constants

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(LoginUseCase(AuthRepositoryImpl())),
        child: Stack(
          children: [
            _buildBackgroundWithContent(context),
            const LanguageButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundWithContent(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: _buildGradient(context)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.115),
            const LoginHeader(),
            const SizedBox(height: 40),
            const LoginErrorWidget(),
            LoginTextField(
              controller: _usernameController,
              labelKey: LocaleKeys.login_username,
              hintKey: LocaleKeys.login_enter_username,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
            LoginTextField(
              controller: _passwordController,
              labelKey: LocaleKeys.login_password,
              hintKey: LocaleKeys.login_enter_password,
              prefixIcon: Icons.lock_outline,
              obscureText: !_isPasswordVisible,
              showPasswordToggle: true,
              onPasswordVisibilityToggle: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 30),
            _buildLoginButtonWithListener(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButtonWithListener(BuildContext context) {
    return Builder(
      builder: (builderContext) {
        return BlocListener<LoginCubit, LoginState>(
          listener: (listenerContext, state) {
            if (state is LoginSuccess) {
              _navigateToDashboard(listenerContext);
            }
          },
          child: LoginButton(
            onPressed: () {
              builderContext.read<LoginCubit>().login(
                _usernameController.text,
                _passwordController.text,
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider<NotificationCubit>(
          create: (context) => getIt<NotificationCubit>(),
          child: const DashboardPage(),
        ),
      ),
    );
  }

  LinearGradient _buildGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.primary.withOpacity(0.2),
        Theme.of(context).colorScheme.primary.withOpacity(0.05),
      ],
    );
  }
}
