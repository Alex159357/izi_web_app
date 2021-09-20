
import 'package:flutter/material.dart';
import 'package:izi_web/screens/auth/auth_page.dart';
import 'package:izi_web/ui/theme/themes.dart';
import 'package:provider/provider.dart';
import 'controllers/MenuController.dart';
import 'ui/theme/theme_switcher/theme_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (BuildContext context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider<MenuController>(
          create: (BuildContext context) => MenuController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Izi Bank',
            theme: notifier.darkTheme ? dark : light,
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuController(),
                ),
              ],
              child: AuthPage(),
            ),
          );
        },
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Izi Bank',
    //   theme: ThemeData.dark().copyWith(
    //     scaffoldBackgroundColor: Theme.of(context).backgroundColor,
    //     textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
    //         .apply(bodyColor: Colors.white),
    //     canvasColor: Theme.of(context).accentColor,
    //   ),
    //   home: MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(
    //         create: (context) => MenuController(),
    //       ),
    //     ],
    //     child: AuthPage(),
    //   ),
    // );
  }
}
