import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mi_musica/pages/home_page.dart';
import 'package:mi_musica/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'Lista.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final _email = TextEditingController();
  final _password = TextEditingController();
  String usu="";
  String cla="";

  Usuario userLoad = Usuario.Empty();

  @override
  void initState(){
    _getUser();
    super.initState();
  }

  _getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoad = Usuario.fromJson(userMap);
}

  void _showMsg(String msg){
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(content: Text(msg),
        action: SnackBarAction(
            label: "Aceptar", onPressed: Scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _validateUser()async{
    usu= _email.text;
    cla= _password.text;
    try {
      final datos = await firebaseAuth.signInWithEmailAndPassword(
          email: usu, password: cla);
      print(datos);
      if (datos != null) {
        print(usu);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Lista())
        );
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: "datos incorrectos", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Center (
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(image: AssetImage("assets/images/viajar.png")),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _email,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Correo Electrónico"
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Contraseña"
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          _validateUser();
                        }, child: const Text("Iniciar Sesión")),
                    TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue)
                          ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                        },
                        child: const Text("Regístrese"),
                      ),
                  ],
              ),
            )),
        );
  }
}
