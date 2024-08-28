import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/authProvider.dart'; // AuthProvider import
import 'package:app/Navigator.dart'; // AppNavigator import
import 'package:app/screens/Login/LoginScreen.dart';// LoginScreen import
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app/screens/ChatScreen/ChatScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MaterialApp(
          theme: ThemeData(fontFamily: "Pretendard"),
          home: authProvider.isLoggedIn ? AppNavigator() : LoginScreen(),
        );
      },
    );
  }
}



