import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_musica/pages/home_page.dart';
import 'package:mi_musica/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repository/usuariofirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  Usuario userLoad = Usuario.Empty();

  final UsuarioFirebase _usuarioFirebase = UsuarioFirebase();

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
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: "Aceptar", onPressed: Scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _validateUser()async{
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg("Debe digitar el correo y la contrasena");
    } else {
      var result = await _usuarioFirebase.logInUser(_email.text, _password.text);
      String msg = "";
      if (result == "invalid-email") {
        msg = "El correo electónico está mal escrito";
      } else if (result == "wrong-password") {
        msg = "Correo o contrasena incorrecta";
      } else if (result == "network-request-failed") {
        msg = "Revise su conexion a internet";
      } else {
        msg = "Usuario registrado con exito";
        _showMsg(msg);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
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
                    const Image(image: AssetImage("assets/images/viajar.png"),
                    ),
                    const SizedBox(
                      height: 16.0,),
                    TextFormField(
                      controller: _email,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Correo Electrónico"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Contraseña"),
                      keyboardType: TextInputType.emailAddress,
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
                              color: Colors.blue)),
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
