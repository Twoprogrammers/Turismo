import 'package:firebase_auth/firebase_auth.dart';

class UsuarioFirebase{
  Future<String?> registrarusuario(String email, String password)async{
    try{
      final credenciales= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return credenciales.user?.uid;
    }
    on FirebaseAuthException catch(e){
      print('FIREBASEAUTHEX${e.code}');
      return e.code;
    }on FirebaseException catch(e){
      return e.code;
    }
  }
}