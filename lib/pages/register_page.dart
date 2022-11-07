import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mi_musica/models/user.dart';
import 'package:mi_musica/pages/login_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre{ masculino, femenino}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  String _data = "Información";

  Genre? _genre = Genre.masculino;

  bool _salsa = false;
  bool _rancheras = false;
  bool _rock = false;

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

  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }


  void _onRegisterButtonClicked() {
    setState(() {
      if(_password.text == _repPassword.text){
      String genre = "Masculino";
      String favoritos = "";

      if (_genre == Genre.femenino) {
        genre = "Femenino";
      }

      if (_salsa) favoritos = "$favoritos Salsa";
      if (_rancheras) favoritos = "$favoritos Rancheras";
      if (_rock) favoritos = "$favoritos Rock";
      var user = User(
          _name.text, _email.text, _password.text, genre, favoritos, _date);
      saveUser(user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                      "Género de Música Favorita",
                      style: TextStyle(fontSize: 20),
                    ),
                    CheckboxListTile(
                      title:  const Text("Salsa"),
                      value: _salsa,
                      selected: _salsa,
                      onChanged: (bool? value) {
                        setState(() {
                          _salsa = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title:  const Text("Rancheras"),
                      value: _rancheras,
                      selected: _rancheras,
                      onChanged: (bool? value) {
                        setState(() {
                          _rancheras = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title:  const Text("Rock"),
                      value: _rock,
                      selected: _rock,
                      onChanged: (bool? value) {
                        setState(() {
                          _rock = value!;
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
