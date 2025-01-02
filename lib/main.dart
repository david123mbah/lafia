
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafia/Controller/main_screen.provider.dart';
import 'package:lafia/routes/routes.dart';
import 'package:provider/provider.dart';


  
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifer()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lafia',
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