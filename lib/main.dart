import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'providers/home_provider.dart';
import 'screens/splash_page.dart';
import 'providers/auth_provider.dart';
import 'services/firebase_service.dart';

late SharedPreferences prefs;
GetIt register = GetIt.instance;

final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

void setupSingletons() {
  register.registerLazySingleton<FirebaseService>(() => FirebaseService());
}

Future<void> initApp() async {
  setupSingletons();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
      name: 'flutter_firebase',
      options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  await initApp();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                    prefs: prefs,
                    firebaseService: _firebaseService,
                    googleSignIn: GoogleSignIn(),
                  )),
          Provider<HomeProvider>(create: (_) => HomeProvider()),
          /**
            * TODO: Add missing provider
            */
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashPage(),
        ));
  }
}
