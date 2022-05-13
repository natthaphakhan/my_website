import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_website/page_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAmodZ6BPKwtTe_J_pGk-vpv86I_r_J48c",
        authDomain: "ultra-syntax-344406.firebaseapp.com",
        projectId: "ultra-syntax-344406",
        storageBucket: "ultra-syntax-344406.appspot.com",
        messagingSenderId: "369631988807",
        appId: "1:369631988807:web:b7178bcb172bb2fa507562",
        measurementId: "G-PMP3JH3T6D"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My website',
      debugShowCheckedModeBanner: false,
      home: PageCtrl(),
    );
  }
}
