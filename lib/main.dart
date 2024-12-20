import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/shared/view_model/shared_component_model.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/home/view_model/device_view_model.dart';
import 'package:landlord_portal/features/home/view_model/landlord_report_view_model.dart';
import 'package:landlord_portal/features/home/view_model/user_view_model.dart';
import 'package:landlord_portal/features/my_properties/model/property_details_model.dart';
import 'package:landlord_portal/features/my_properties/model/property_model.dart';
import 'package:landlord_portal/features/splash_screen/splash_screen.dart';
import 'package:landlord_portal/features/splash_screen/view_model/splash_screen_view_model.dart';
import 'package:landlord_portal/features/statements/view_model/statement_view_model.dart';
import 'package:landlord_portal/firebase_options.dart';
import 'package:landlord_portal/store/navigation_provider.dart';
import 'package:provider/provider.dart';
// core FlutterFire dependency
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    customDebugPrint("Handling a background message: ${message.messageId}");
    customDebugPrint('Message data: ${message.data}');
    customDebugPrint('Message notification: ${message.notification?.title}');
    customDebugPrint('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  void handleBackgroundMessaging() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  handleBackgroundMessaging();

  if (const bool.fromEnvironment('IS_LOCAL', defaultValue: true)) {
    await dotenv.load(fileName: ".env");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (content) => DeviceProvider(),
        ),
        ChangeNotifierProvider(
          create: (content) => StatementProvider(),
        ),
        ChangeNotifierProvider(
          create: (content) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (content) => LandlordProvider(),
        ),
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
        ),
        ChangeNotifierProvider(
          create: (context) => SplashScreenProvider(),
        ),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 826),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Landlord Connect - Short Term Rentals',
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
        home: child,
      ),
      child: const SplashScreen(),
    );
  }
}
