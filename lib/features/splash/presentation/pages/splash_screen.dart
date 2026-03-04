import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notification_dashboard/core/services/firebase_messaging_service.dart';
import 'package:notification_dashboard/features/auth/presentation/pages/login_page.dart';
import 'package:notification_dashboard/generated/locale_keys.g.dart';

/// Splash Screen - Shows while Firebase initializes
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
  }

  @override
  void didChangeDependencies() async {
    // Step 0: Initial delay (1 second)
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _currentStep = 1);

    // Step 1: Firebase initialization (3 seconds to show status)
    await FirebaseMessagingService.initialize();
    if (mounted) setState(() => _currentStep = 2);

    // Step 2: Setup completion delay (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    super.didChangeDependencies();
  }

  String _getStatusText() {
    switch (_currentStep) {
      case 0:
        return LocaleKeys.splash_welcome.tr();
      case 1:
        return LocaleKeys.splash_initializing_firebase.tr();
      case 2:
        return LocaleKeys.splash_ready_to_go.tr();
      default:
        return LocaleKeys.splash_loading.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Notification Icon with border
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.dashboard,
                        size: 150,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // App Title
                Text(
                  LocaleKeys.splash_app_title.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Tagline
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    LocaleKeys.splash_tagline.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 50),

                // Status indicator with dots progression
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _getStatusText(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Progress dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: _currentStep > index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentStep > index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 80),

                // Bottom footer text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    LocaleKeys.splash_footer.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
