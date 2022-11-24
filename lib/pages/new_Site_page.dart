import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mi_musica/models/sitios.dart';

<<<<<<< HEAD
import '../repository/usuarioFirebase.dart';


=======
import '../repository/usuariofirebase.dart';
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2

class NewSitePage extends StatefulWidget {
  const NewSitePage({Key? key}) : super(key: key);

  @override
  State<NewSitePage> createState() => _NewSitePageState();
}

class _NewSitePageState extends State<NewSitePage> {
  final UsuarioFirebase _usuarioFirebase = UsuarioFirebase();

<<<<<<< HEAD
  final _nameSite = TextEditingController();
  final _town = TextEditingController();
  final _generalDescription = TextEditingController();
  final _department = TextEditingController();
  final _detailedDescription = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  final _photo = TextEditingController();
=======
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2

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
<<<<<<< HEAD
  void _createSitio(Site sitio) async{
=======
  void _createSitio(Sitios sitio) async{
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
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
<<<<<<< HEAD
    var sitio = Site("", _nameSite.text, _generalDescription.text, _town.text, _department.text, _detailedDescription.text, _latitude.text, _longitude.text, genres, _photo.text, _rating.toDouble() );
    _createSitio(sitio);
  }


=======
    var sitio = Sitios("", _name.text, _location.text, _description.text, _rating, genres);
    _createSitio(sitio);
  }

>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
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
<<<<<<< HEAD
                controller: _nameSite,
=======
                controller: _name,
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
<<<<<<< HEAD
                controller: _department,
=======
                controller: _location,
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Localización'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
<<<<<<< HEAD
                height: 12.0,
              ),

              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _detailedDescription,
=======
                height: 16.0,
              ),
              TextFormField(
                controller: _description,
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción'),
                keyboardType: TextInputType.text,
              ),
<<<<<<< HEAD
              TextFormField(
                controller: _photo,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pega aqui la URL de la iamgen',
                    suffixIcon: Icon(Icons.ad_units_outlined)),
                keyboardType: TextInputType.text,

              ),
=======
>>>>>>> c3efb2251ce6bbca656782e8eb8decb5c8dcfce2
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

