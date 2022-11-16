import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mi_musica/models/user.dart';
import 'package:mi_musica/pages/login_page.dart';
import '../repository/usuarioFirebase.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre{ masculino, femenino}

class _RegisterPageState extends State<RegisterPage> {

  final UsuarioFirebase _usuarioFirebase = UsuarioFirebase();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  String _data = "Información";

  Genre? _genre = Genre.masculino;

  bool _Europa = false;
  bool _AmericaLatina = false;
  bool _Asia = false;

  String buttonMsg = "Fecha de Nacimiento";

  String _date = "";

  String _dateConverter(DateTime newDate){
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void  _showSelectDate() async{
    final DateTime? newDate = await showDatePicker(
      context: context,
      locale: const Locale("es", "CO"),
      initialDate: DateTime(2022,10),
      firstDate: DateTime(1900,1),
      lastDate: DateTime(2022,12),
      helpText: "Fecha de Nacimiento",
    );
    if (newDate != null){
      setState(() {
        _date = _dateConverter(newDate);
        buttonMsg = "Fecha de Nacimiento: ${_date.toString()}";
      });
    }
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

  void _saveUser(Usuario user) async {
    var result = await _usuarioFirebase.crearUsuario(user);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _registerUser(Usuario user) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("user", jsonEncode(user));
    var result = await _usuarioFirebase.registrarUsuario(user.email, user.password);
    String msg = "";
    if (result == "invalid-email") {
      msg = "El correo electónico está mal escrito";
    } else if (result == "weak-password") {
      msg = "La contrasena debe tener minimo 6 digitos";
    } else if (result == "email-already-in-use") {
      msg = "Ya existe una cuenta con ese correo electronico";
    } else if (result == "network-request-failed") {
      msg = "Revise su conexion a internet";
    } else {
      msg = "Usuario registrado con exito";
      user.uid = result;
      _saveUser(user);
    }
    _showMsg(msg);
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if(_password.text == _repPassword.text){
      String genre = "Masculino";
      String favoritos = "";

      if (_genre == Genre.femenino) {
        genre = "Femenino";
      }

      if (_Europa) favoritos = "$favoritos Europa";
      if (_AmericaLatina) favoritos = "$favoritos AmericaLatina";
      if (_Asia) favoritos = "$favoritos Asia";
      var user = Usuario("", _name.text, _email.text, _password.text, genre,
          favoritos, _date);
      _registerUser(user);
      } else {
        _showMsg("Las contraseñas deben de ser iguales");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Center (
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(image: AssetImage("assets/images/viajar.png")),
                      const SizedBox(
                        height: 16.0,
                      ),
                    TextFormField(
                      controller: _name,
                      decoration:  const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nombre"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _email,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Correo Electrónico"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Contraseña"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _repPassword,
                      decoration:  const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Repita Contraseña"),
                      keyboardType: TextInputType.text,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                            ListTile(
                              title: const Text("Masculino"),
                              leading: Radio<Genre>(
                                  value: Genre.masculino,
                                  groupValue: _genre,
                                  onChanged: (Genre? value){
                                    setState(() {
                                      _genre = value;
                                    });
                                  }
                              ),
                            ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Text("Femenino"),
                                leading: Radio<Genre>(
                                    value: Genre.femenino,
                                    groupValue: _genre,
                                    onChanged: (Genre? value){
                                      setState(() {
                                        _genre = value;
                                      });
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                    const Text(
                      "Continente de interes",
                      style: TextStyle(fontSize: 20),
                    ),
                    CheckboxListTile(
                      title:  const Text("Europa"),
                      value: _Europa,
                      selected: _Europa,
                      onChanged: (bool? value) {
                        setState(() {
                          _Europa = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title:  const Text("America Latina"),
                      value: _AmericaLatina,
                      selected: _AmericaLatina,
                      onChanged: (bool? value) {
                        setState(() {
                          _AmericaLatina = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title:  const Text("Asia"),
                      value: _Asia,
                      selected: _Asia,
                      onChanged: (bool? value) {
                        setState(() {
                          _Asia = value!;
                        });
                      },
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        _showSelectDate();

                      },
                      child: Text(buttonMsg),
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        _onRegisterButtonClicked();
                      },
                      child: const Text("Registrar"),
                    ),
                    ],
                ),
              ),
            )),
      );
    }
}
