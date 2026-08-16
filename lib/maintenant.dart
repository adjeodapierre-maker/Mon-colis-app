import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'VOTRE_URL_SUPABASE',
    anonKey: 'VOTRE_CLE_ANON',
  );
  runApp(const MonColisApp());
}

class MonColisApp extends StatelessWidget {
  const MonColisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MonColis',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion MonColis')),
      body: const Center(child: Text('Page de connexion ici')),
    );
  }
}
