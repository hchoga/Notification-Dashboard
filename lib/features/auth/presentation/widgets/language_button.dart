import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notification_dashboard/generated/locale_keys.g.dart';

/// Language switcher button
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: PopupMenuButton<Locale>(
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.language_change.tr(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.language, color: Colors.grey),
          ],
        ),
        tooltip: 'Change Language',
        onSelected: (Locale locale) {
          context.setLocale(locale);
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<Locale>(
            value: const Locale('en'),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(LocaleKeys.language_english.tr()),
              ],
            ),
          ),
          PopupMenuItem<Locale>(
            value: const Locale('ar'),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(LocaleKeys.language_arabic.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
