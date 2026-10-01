import 'package:ecommerce_app/utitlities/app_router.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_models/favorite_Product_cubit/fav_product_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _navigatorKey=GlobalKey<NavigatorState>();
Future<void> main() async {
  await initializeApp();
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await handleNotifications();
}

Future<void> handleNotifications() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
        'Message also contained a notification: ${message.notification}',
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Got a new message opened was published');
    if (message.data["product_id"] != null) {
      _navigatorKey.currentState!.pushNamed(
        AppRoutes.productDetailsPage,
        arguments: message.data["product_id"],
      );
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CartCubit()),
            BlocProvider(
              create: (context) {
                final cubit = FavProductCubit();
                return cubit;
              },
            ),
            BlocProvider(
              create: (context) {
                final cubit = AuthCubit();
                cubit.checkAuth();
                return cubit;
              },
            ),
          ],
          child: Builder(
            builder: (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                bloc: BlocProvider.of<AuthCubit>(context),
                buildWhen: (previous, current) =>
                    current is AuthDone ||
                    current is AuthInitial ||
                    current is AuthFailed,
                builder: (context, state) {
                  return MaterialApp(
                    navigatorKey: _navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: 'E-Commerce App',
                    theme: ThemeData(
                      // This is the theme of your application.
                      //
                      // TRY THIS: Try running your application with "flutter run". You'll see
                      // the application has a purple toolbar. Then, without quitting the app,
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
                      colorScheme: .fromSeed(seedColor: Colors.deepPurple),
                      useMaterial3: true,
                    ),
                    initialRoute: state is AuthDone
                        ? AppRoutes.homePage
                        : AppRoutes.loginPage,
                    onGenerateRoute: AppRouter.onGenerate,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
