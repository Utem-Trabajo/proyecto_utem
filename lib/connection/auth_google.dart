import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthUser {
  static Future<User?> loginGoogle() async {
    // Iniciar sesión con Google
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Autenticar con Firebase Auth
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    // Verificar si el usuario ya ha ingresado datos
    if (user != null) {
      bool hasEnteredData = await hasUserDataEntered(user.uid);
      if (hasEnteredData) {
        // Si ya ha ingresado datos, guardar este estado localmente
        await saveDataEnteredStatus(true);
      }
    }

    return user;
  }

  static Future<bool> hasUserDataEntered(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData['datosIngresados'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al verificar datos ingresados: $e');
      return false;
    }
  }

  static Future<void> saveDataEnteredStatus(bool hasEntered) async {
    // Implementar lógica para guardar el estado local si es necesario
  }
}
