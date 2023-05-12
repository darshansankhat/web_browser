import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_browser/Provider_screen/Provider_screen.dart';
import 'package:web_browser/Splash_screen/Splash_screen.dart';
import 'package:web_browser/Viwe_screen/Browser_screen.dart';

void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Browser_provider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "/":(context) => Browser_screen(),
          "splash":(context) => Splash_screen(),
        },
        theme: ThemeData.dark(),
      ),
    ),
  );
}