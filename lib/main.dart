import 'package:application_de_reservation_de_ressources/providers/admin_provider.dart';
import 'package:application_de_reservation_de_ressources/views/admin/add_resource_page.dart';
import 'package:application_de_reservation_de_ressources/views/admin/admin_resources_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/resource_provider.dart';
import 'providers/calendar_provider.dart';

import 'views/auth/login_page.dart';
import 'views/auth/signup_page.dart';
import 'views/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ResourceProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resource Reservation',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => const HomePage(),
        '/admin/resources': (_) => const AdminResourcesPage(),
        '/admin/add-resource': (_) => AddResourcePage(),
      },
    );
  }
}
