import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              height: 50,
              color: Colors.white,
              child: Text('LISTADO DE LUGARES', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'titulo',
              ),),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 5),
              child: ListTile(
                title: Text('NICARAGUA'),
                subtitle: Text('lugar turistico'),
                leading: Icon(Icons.add_location_alt_rounded, color: Colors.black,),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 5),
              child: ListTile(
                title: Text('COLOMBIA'),
                subtitle: Text('lugar turistico'),
                leading: Icon(Icons.add_location_alt_rounded, color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
