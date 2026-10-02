// main.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/utils/App_theme.dart';
import 'package:movies_app/core/utils/app_routs.dart';
import 'package:movies_app/screens/authntication/forget_password.dart';
import 'package:movies_app/screens/authntication/login.dart';
import 'package:movies_app/screens/authntication/register.dart';

import 'package:movies_app/screens/home/home_screen.dart';
import 'package:movies_app/screens/home/tabs/homeTab/movieDetails/movie_details_screen.dart';

import 'package:movies_app/screens/onboarding/on_boarding1.dart';
import 'package:movies_app/screens/onboarding/on_boarding2.dart';

import 'package:movies_app/screens/update_profile/update_profile.dart';
import 'package:movies_app/screens/update_profile/update_profile_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        // Onboarding
        AppRouts.onBoarding1: (context) => OnBoarding1(),

        AppRouts.onBoarding2: (context) => OnBoarding2(),

        // Authentication
        AppRouts.register: (context) => Register(),

        AppRouts.loginRouteName: (context) => LoginScreen(),

        AppRouts.forgetPasswordRouteName: (context) => ForgetPassword(),

        // Update Profile
        AppRouts.updateProf: (context) {
          return BlocProvider(
            create: (_) => UpdateProfileCubit()..getUserData(),
            child: const UpdateProfile(),
          );
        },

        // Home
        AppRouts.homeRouteName: (context) => HomeScreen(),

        // Movie Details
        AppRouts.MovieDetailsscreen: (context) => MovieDetailsScreen(),
      },

      // Start with onboarding
      initialRoute: AppRouts.onBoarding1,

      // Localization
      localizationsDelegates: context.localizationDelegates,

      supportedLocales: context.supportedLocales,

      locale: context.locale,

      // Theme
      darkTheme: AppTheme.DarkMode,
      themeMode: ThemeMode.dark,
    );
  }
}
