import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafia/Controller/main_screen.provider.dart';
import 'package:lafia/pages/Doctors/doctorview.dart';
import 'package:lafia/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifer()),
    ChangeNotifierProvider(create: (context) => DoctorProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'freemind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Initial route
      getPages: TAppRoute.pages,
    );
  }
}