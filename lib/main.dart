import 'package:afsgo_case_study/provider/provider_data.dart';
import 'package:afsgo_case_study/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>ProviderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: HomePage(),
      ),
    );
  }
}

