import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/providers/movie_provider.dart';
import 'package:corona/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
      ],
      child: const NetFlix(),
    ),
  );
}

class NetFlix extends StatefulWidget {
  const NetFlix({super.key});

  @override
  State<NetFlix> createState() => _NetFlixState();
}

class _NetFlixState extends State<NetFlix> {
  late ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = ThemeController();
    final themeController =
        Provider.of<ThemeController>(context, listen: false);

    final brightness =
        ThemeData.estimateBrightnessForColor(themeController.primaryColor);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: themeController.primaryColor,
      statusBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: themeController.primaryColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeController.whiteColor,
        iconTheme: IconThemeData(
          color: themeController.textColor, // Set your desired icon color here
          size: screenHeight(context) * 2.5, // Set default size if needed
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              color: themeController.textColor), // Example headline1 color
          bodyText1: TextStyle(
              color: themeController.textColor), // Example body text color
          bodyText2: TextStyle(
              color: themeController.textColor), // Example body text color
          caption: TextStyle(
              color: themeController.textColor), // Example caption text color
        ),
      ),
      home: SplashScreen(),
    );
  }
}
