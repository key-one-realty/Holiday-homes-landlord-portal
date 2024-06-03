import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:landlord_portal/components/shared/view_model/shared_component_model.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/my_properties/model/property_details_model.dart';
import 'package:landlord_portal/features/my_properties/model/property_model.dart';
import 'package:landlord_portal/features/splash_screen/splash_screen.dart';
import 'package:landlord_portal/store/navigation_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (const bool.fromEnvironment('IS_LOCAL', defaultValue: true)) {
    await dotenv.load(fileName: ".env");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (content) => PropertyDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (content) => PropertyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedComponentModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthPovider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyone Homes Portal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(55, 126, 79, 1),
          primary: const Color.fromRGBO(55, 126, 79, 1),
          secondary: const Color(0xFFBEA354),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
