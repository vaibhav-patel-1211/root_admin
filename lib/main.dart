import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_admin/Profile/profile_service.dart';
import 'package:root_admin/firebase_options.dart';
import 'package:root_admin/services/image_service.dart';
import 'package:root_admin/screens/Auth/auth_screen.dart';
import 'package:root_admin/screens/Auth/auth_service.dart';
import 'package:root_admin/theme/app_theme.dart';
import 'package:root_admin/localization/app_translations.dart';
import 'package:root_admin/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.setupFirebaseMessaging();
  await NotificationService.subscribeAdmin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',

        // Applying theme
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        // Localization
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),

        // Initial binding for AuthService
        initialBinding: BindingsBuilder(
          () {
            Get.put(AuthService());
            Get.put(ProfileService());
            Get.put(ImageService());
          },
        ),

        // Home page
        home: const AuthScreen()
        // home: const ProductCategory(),
        );
  }
}
