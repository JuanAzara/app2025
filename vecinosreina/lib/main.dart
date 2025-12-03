import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vecinosreina/screens/actividad.dart';
import 'package:vecinosreina/screens/inicio.dart';
import 'package:vecinosreina/screens/splashscreen.dart';
import 'package:vecinosreina/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: "AIzaSyCTq4R7OG87UTKzyWeHH8MAksL_husouB4",
  authDomain: "vecinosreina.firebaseapp.com",
  projectId: "vecinosreina",
  storageBucket: "vecinosreina.firebasestorage.app",
  messagingSenderId: "796725408665",
  appId: "1:796725408665:web:bc401312ed2f257579d908"
      ),
    );
 } on FirebaseException catch (e) {
    // Si la app ya estaba inicializada, ignora el error
    if (e.code != 'duplicate-app') rethrow;
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InicioScreen();
  }
}
