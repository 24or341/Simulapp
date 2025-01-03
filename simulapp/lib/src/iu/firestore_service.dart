// lib/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  // Función para registrar un usuario en Firestore
  Future<void> registerUser(String email, String password, String nombre) async {
    try {
      // Verificar si el usuario ya existe
      QuerySnapshot result = await usuarios.where('email', isEqualTo: email).get();
      if (result.docs.isEmpty) {
        // Si no existe, registrar al nuevo usuario
        await usuarios.add({
          'email': email,
          'password': password, // ¡Recuerda encriptar en un entorno real!
          'nombre': nombre,
        });
        print('Usuario registrado con éxito');
      } else {
        print('El usuario ya existe');
      }
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  // Función para hacer login
  Future<void> loginUser(String email, String password) async {
    try {
      QuerySnapshot result = await usuarios
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password) // ¡Recuerda encriptar!
          .get();

      if (result.docs.isNotEmpty) {
        print('Login exitoso');
        // Aquí puedes manejar la sesión del usuario
      } else {
        print('Email o contraseña incorrectos');
      }
    } catch (e) {
      print('Error al hacer login: $e');
    }
  }
}
