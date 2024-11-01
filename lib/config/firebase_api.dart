import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:landlord_portal/features/home/view_model/device_view_model.dart';
import 'package:landlord_portal/firebase_options.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseFCM {
  void handleForegroundMessaging() {
    // Set up foreground message handler
    // used to pass messages from event handler to the UI
    final messageStreamController = BehaviorSubject<RemoteMessage>();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }

      messageStreamController.sink.add(message);
    });
  }

  void registerApp(FirebaseMessaging messaging) async {
    String? vapidKey = dotenv.env["VAPID_KEY"];

    // use the registration token to send messages to users from your trusted server environment
    String? token;

    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      token = await messaging.getToken(
        vapidKey: vapidKey,
      );
    } else {
      token = await messaging.getToken();
    }

    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }

  void initializeFirebase() async {
    // Request permission
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }

    registerApp(messaging);

    handleForegroundMessaging();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      DeviceProvider deviceContextProvider = DeviceProvider();

      deviceContextProvider.deviceReceivedNotification();
    });

    // handleBackgroundMessaging();
  }
}
