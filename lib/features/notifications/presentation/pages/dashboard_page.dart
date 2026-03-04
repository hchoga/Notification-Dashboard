import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_dashboard/service_locator.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/notification_cubit.dart';
import '../bloc/notification_state.dart';
import '../widgets/emotion_picker.dart';

/// Dashboard Page - Notification Sender
/// Allows users to send notifications to devices
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: 20),
              Text(LocaleKeys.send_notification.tr()),
            ],
          ),
          elevation: 2,
          actions: [
            // Language display and selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Current language text
                  // Language selector dropdown
                  PopupMenuButton<Locale>(
                    icon: Row(
                      children: [
                        Text(
                          LocaleKeys.language_change.tr(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.language),
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
                ],
              ),
            ),
          ],
        ),
        body: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            } else if (state is NotificationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              // Reset form after successful send
              _titleController.clear();
              _bodyController.clear();
            }
          },
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return _buildForm(context, state);
            },
          ),
        ),
      ),
    );
  }

  /// Build the notification sending form
  Widget _buildForm(BuildContext context, NotificationState state) {
    final isSending = state is NotificationSending;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              LocaleKeys.send_to_devices.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.enter_notification_details.tr(),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: AppConstants.defaultPadding * 2),

            // Title field
            TextFormField(
              controller: _titleController,
              enabled: !isSending,
              decoration: InputDecoration(
                labelText: LocaleKeys.notification_title.tr(),
                hintText: LocaleKeys.placeholder_enter_title.tr(),
                prefixIcon: const Icon(Icons.title),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  tooltip: LocaleKeys.emotion_add_emotion.tr(),
                  onPressed: !isSending ? _showTitleEmotionPicker : null,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return LocaleKeys.validation_title_required.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding),

            // Body field
            TextFormField(
              controller: _bodyController,
              enabled: !isSending,
              minLines: 2,
              maxLines: 8,
              decoration: InputDecoration(
                labelText: LocaleKeys.notification_body.tr(),
                hintText: LocaleKeys.placeholder_enter_message.tr(),
                prefixIcon: const Icon(Icons.message),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  tooltip: LocaleKeys.emotion_add_emotion.tr(),
                  onPressed: !isSending ? _showBodyEmotionPicker : null,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return LocaleKeys.validation_message_required.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding * 2),

            // Send button
            ElevatedButton.icon(
              onPressed: isSending ? null : _sendNotification,
              icon: isSending
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(
                isSending
                    ? LocaleKeys.button_clear_form.tr()
                    : LocaleKeys.send_notification.tr(),
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),

            // Reset button
            OutlinedButton.icon(
              onPressed: isSending ? null : _resetForm,
              icon: const Icon(Icons.refresh),
              label: Text(LocaleKeys.button_clear_form.tr()),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show emotion picker for title field
  void _showTitleEmotionPicker() {
    showDialog(
      context: context,
      builder: (context) => EmotionPicker(
        onEmotionSelected: (emotion) {
          _titleController.text += emotion;
          // Move cursor to end
          _titleController.selection = TextSelection.fromPosition(
            TextPosition(offset: _titleController.text.length),
          );
        },
      ),
    );
  }

  /// Show emotion picker for body field
  void _showBodyEmotionPicker() {
    showDialog(
      context: context,
      builder: (context) => EmotionPicker(
        onEmotionSelected: (emotion) {
          _bodyController.text += emotion;
          // Move cursor to end
          _bodyController.selection = TextSelection.fromPosition(
            TextPosition(offset: _bodyController.text.length),
          );
        },
      ),
    );
  }

  /// Send notification
  void _sendNotification() {
    if (_formKey.currentState!.validate()) {
      context.read<NotificationCubit>().sendNotification(
        token: '', // Token will be fetched from Firebase device
        title: _titleController.text,
        body: _bodyController.text,
      );
    }
  }

  /// Reset the form
  void _resetForm() {
    _titleController.clear();
    _bodyController.clear();
    _formKey.currentState?.reset();
    context.read<NotificationCubit>().resetForm();
  }
}
