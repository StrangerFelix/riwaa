// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

// class FirebaseNotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = 
//       FlutterLocalNotificationsPlugin();
      
//   Future<void> initializeFirebase() async {
//     // Request permission
//     // ignore: unused_local_variable
//     NotificationSettings settings = await _messaging.requestPermission();
    
//     // Initialize local notifications
//     const AndroidInitializationSettings androidSettings = 
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iOSSettings = 
//         DarwinInitializationSettings();
//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iOSSettings,
//     );
    
//     await _localNotifications.initialize(initSettings);
    
//     // Set up foreground notification presentation
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
    
//     // Listen for messages
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
//     // Get token for this device
//     String? token = await _messaging.getToken();
//     print("FCM Token: $token");
//     // Store this token in your database to send notifications to this device
//   }
  
//   void _handleForegroundMessage(RemoteMessage message) {
//     print("Got foreground message: ${message.notification?.title}");
    
//     if (message.notification != null) {
//       _localNotifications.show(
//         message.hashCode,
//         message.notification!.title,
//         message.notification!.body,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'plant_watering_channel',
//             'Plant Watering Notifications',
//             importance: Importance.high,
//             priority: Priority.high,
//           ),
//           iOS: DarwinNotificationDetails(),
//         ),
//       );
//     }
//   }
// }