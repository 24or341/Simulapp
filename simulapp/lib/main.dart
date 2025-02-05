import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'src/data/conection.dart'; // Inicializa Firebase
import 'src/iu/login.dart'; // Pantalla de Login
import 'src/iu/register.dart'; // Pantalla de Registro

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); // Inicializa Firebase antes de arrancar la app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthCheck(), // Verifica el estado de autenticación
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si el usuario está autenticado, lo redirigimos a la pantalla principal
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LoginScreen(); // Si no hay usuario, muestra la pantalla de login
          } else {
            return RegisterScreen(); // Si hay usuario, muestra la pantalla de registro o la principal
          }
        } else {
          // Si el estado de conexión está cargando
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
