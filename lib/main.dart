import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graduation_project/ui/auth/login/login.dart';
import 'package:graduation_project/ui/home/home_screen.dart';
import 'cache/cache_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.cacheInitialization();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CacheHelper.email = CacheHelper.getUserEmail();
    CacheHelper.id = CacheHelper.getUserId();
    CacheHelper.name = CacheHelper.getUserName();
    CacheHelper.isPremium = CacheHelper.getUserIsPremium();

    return SafeArea(
      maintainBottomViewPadding: true,
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        routes: {
          Login.routeName: (_) => const Login(),
          HomeScreen.routeName: (_) => const HomeScreen(),
        },
        initialRoute:
            CacheHelper.email != null ? HomeScreen.routeName : Login.routeName,
      ),
    );
  }
}