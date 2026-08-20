import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yljxmdxjihvldslxlagu.supabase.co',
    anonKey: 'sb_publishable_By98bQn5pV_auTDXCcFc2g_-8RHHxug',
  );

  runApp(const MonColisApp());
}

final supabase = Supabase.instance.client;

class MonColisApp extends StatelessWidget {
  const MonColisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MON Colis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool inscription = false;
  bool chargement = false;

  Future<void> authentifier() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
        ),
      );
      return;
    }

    setState(() => chargement = true);

    try {
      if (inscription) {
        await supabase.auth.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compte créé avec succès.'),
          ),
        );

        setState(() => inscription = false);
      } else {
        await supabase.auth.signInWithPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const AccueilPage(),
          ),
        );
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }

    if (mounted) {
      setState(() => chargement = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_shipping,
                size: 85,
                color: Colors.blue,
              ),
              const SizedBox(height: 15),
              const Text(
                'MON COLIS',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Livrer simplement. Livrer rapidement.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Adresse e-mail',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: chargement ? null : authentifier,
                  child: chargement
                      ? const CircularProgressIndicator()
                      : Text(
                          inscription
                              ? 'CRÉER MON COMPTE'
                              : 'SE CONNECTER',
                        ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() => inscription = !inscription);
                },
                child: Text(
                  inscription
                      ? 'J’ai déjà un compte'
                      : 'Créer un compte',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MON Colis'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenue sur MON Colis',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.store),
              label: const Text('ESPACE MARCHAND'),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delivery_dining),
              label: const Text('ESPACE LIVREUR'),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () async {
                await supabase.auth.signOut();

                if (!context.mounted) return;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AuthPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
