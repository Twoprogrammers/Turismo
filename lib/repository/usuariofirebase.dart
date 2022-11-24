import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_musica/models/sitios.dart';
import 'package:mi_musica/models/user.dart' as UserApp;


class UsuarioFirebase{
  Future<String?> registrarUsuario(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String?> logInUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
  Future<String> crearUsuario(UserApp.Usuario user) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(user.ToJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
  Future<String> createSitio(Sitios sitio) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final document = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("sitios")
          .doc();
      sitio.id = document.id;

      final result = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("sitios")
          .doc(sitio.id)
          .set(sitio.toJson());
      return sitio.id;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
}



