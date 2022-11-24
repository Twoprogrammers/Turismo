import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mi_musica/models/sitios.dart';

import '../repository/usuariofirebase.dart';

class NewSitePage extends StatefulWidget {
  const NewSitePage({Key? key}) : super(key: key);

  @override
  State<NewSitePage> createState() => _NewSitePageState();
}

class _NewSitePageState extends State<NewSitePage> {
  final UsuarioFirebase _usuarioFirebase = UsuarioFirebase();

  final _name = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();

  double _rating = 3.0;

  bool _artisticos = false, _culturales = false, _aventura = false, _historicos = false;
  bool _religiosos = false, _romance = false;

  void _showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(msg),
        action: SnackBarAction(
            label: 'Aceptar', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  void _createSitio(Sitios sitio) async{
    var result = await _usuarioFirebase.createSitio(sitio);
    _showMsg(result);
    Navigator.pop(context);
  }
  void _saveSite() {
    var genres = "";
    if (_artisticos) genres = "$genres Artísticos";
    if (_culturales) genres = "$genres Culturales";
    if (_aventura) genres = "$genres Aventura";
    if (_historicos) genres = "$genres Históricos";
    if (_religiosos) genres = "$genres Religiosos";
    if (_romance) genres = "$genres Románticos";
    var sitio = Sitios("", _name.text, _location.text, _description.text, _rating, genres);
    _createSitio(sitio);
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Sitio"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _location,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Localización'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "Sitios Turísticos",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Artísticos"),
                      value: _artisticos,
                      selected: _artisticos,
                      onChanged: (bool? value) {
                        setState(() {
                          _artisticos = value!;
                        });
                      } ,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Aventura"),
                      value: _aventura,
                      selected: _aventura,
                      onChanged: (bool? value) {
                        setState(() {
                          _aventura = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Culturales"),
                      value: _culturales,
                      selected: _culturales,
                      onChanged: (bool? value) {
                        setState(() {
                          _culturales = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Históricos"),
                      value: _historicos,
                      selected: _historicos,
                      onChanged: (bool? value) {
                        setState(() {
                          _historicos = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Religiosos"),
                      value: _religiosos,
                      selected: _religiosos,
                      onChanged: (bool? value) {
                        setState(() {
                          _religiosos= value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Románticos"),
                      value: _romance,
                      selected: _romance,
                      onChanged: (bool? value) {
                        setState(() {
                          _romance = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveSite();
                },
                child: const Text("Guardar Sitio"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

