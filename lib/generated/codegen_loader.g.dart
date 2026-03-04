// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "appTitle": "لوحة التحكم للإشعارات",
  "send": {
    "notification": "إرسال إشعار",
    "to_devices": "إرسال إشعار إلى الأجهزة"
  },
  "enter": {
    "notification_details": "أدخل تفاصيل الإشعار وأرسله إلى جميع الأجهزة المتصلة"
  },
  "notification": {
    "title": "عنوان الإشعار",
    "body": "محتوى الإشعار"
  },
  "placeholder": {
    "enter_title": "أدخل عنوان الإشعار",
    "enter_message": "أدخل رسالة الإشعار"
  },
  "validation": {
    "title_required": "العنوان مطلوب",
    "message_required": "الرسالة مطلوبة",
    "title_error": "يرجى إدخال عنوان الإشعار",
    "body_error": "يرجى إدخال محتوى الإشعار"
  },
  "button": {
    "sending": "جاري الإرسال...",
    "clear_form": "مسح النموذج"
  },
  "message": {
    "success": "تم إرسال الإشعار بنجاح إلى جميع الأجهزة!"
  },
  "language": {
    "english": "English",
    "arabic": "العربية",
    "change": "تغير اللغة"
  },
  "emotion": {
    "select": "اختر الرموز التعبيرية",
    "add_emotion": "إضافة رموز تعبيرية"
  },
  "login": {
    "welcome_back": "أهلا بك",
    "sign_in_account": "قم بتسجيل الدخول إلى حسابك",
    "username": "اسم المستخدم",
    "password": "كلمة المرور",
    "enter_username": "أدخل اسم المستخدم",
    "enter_password": "أدخل كلمة المرور",
    "sign_in": "تسجيل الدخول",
    "both_required": "يرجى إدخال اسم المستخدم وكلمة المرور",
    "invalid_credentials": "اسم المستخدم أو كلمة المرور غير صحيحة"
  },
  "splash": {
    "welcome": "أهلا بك",
    "initializing_firebase": "جاري تهيئة الإشعارات..",
    "ready_to_go": "جاهز للعمل!",
    "loading": "جاري التحميل...",
    "app_title": "لوحة التحكم للإشعارات",
    "tagline": "إدارة وإرسال الإشعارات بسهولة",
    "footer": "جاري إعداد تفضيلات الإشعارات..."
  }
};
static const Map<String,dynamic> _en = {
  "appTitle": "Notification Dashboard",
  "send": {
    "notification": "Send Notification",
    "to_devices": "Send Notification to Devices"
  },
  "enter": {
    "notification_details": "Enter the notification details and send to all connected devices"
  },
  "notification": {
    "title": "Notification Title",
    "body": "Notification Body"
  },
  "placeholder": {
    "enter_title": "Enter notification title",
    "enter_message": "Enter notification message"
  },
  "validation": {
    "title_required": "Title is required",
    "message_required": "Message is required",
    "title_error": "Please enter a notification title",
    "body_error": "Please enter a notification body"
  },
  "button": {
    "sending": "Sending...",
    "clear_form": "Clear Form"
  },
  "message": {
    "success": "Notification sent successfully to all devices!"
  },
  "language": {
    "english": "English",
    "arabic": "العربية",
    "change": "Change Language"
  },
  "emotion": {
    "select": "Select Emotion",
    "add_emotion": "Add Emotion"
  },
  "login": {
    "welcome_back": "Welcome",
    "sign_in_account": "Sign in to your account",
    "username": "Username",
    "password": "Password",
    "enter_username": "Enter username",
    "enter_password": "Enter password",
    "sign_in": "Sign In",
    "both_required": "Please enter both username and password",
    "invalid_credentials": "Invalid username or password"
  },
  "splash": {
    "welcome": "Welcome",
    "initializing_firebase": "Initializing Firebase...",
    "ready_to_go": "Ready to go!",
    "loading": "Loading...",
    "app_title": "Notification Dashboard",
    "tagline": "Manage and send notifications with ease",
    "footer": "Setting up your notification preferences..."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
