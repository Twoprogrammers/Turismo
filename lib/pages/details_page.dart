import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../boxes.dart';
import '../models/local_site.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'location_page.dart';
import 'login_page.dart';

class DetailsPage extends StatefulWidget {
  late QueryDocumentSnapshot capturingDatas;

  DetailsPage(this.capturingDatas,{super.key});


  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

enum Menu{logOut}

class _DetailsPageState extends State<DetailsPage> {

  var isFavorite = false;

  @override
  void initState() {
    _getLocalSite();
    super.initState();
  }

  void _getLocalSite(){
    final box = Boxes.getFavoritesBox();
    box.values.forEach((element) {
      if (element.id == widget.capturingDatas.id){
        isFavorite = true;
      }
    });
  }

  void _onFavoritesButtonClicked() async{

    var localSite = LocalSite()
      ..id = widget.capturingDatas['id']
      ..nameSite = widget.capturingDatas['nameSite']
      ..generalDescription = widget.capturingDatas['generalDescription']
      ..photo = widget.capturingDatas['photo']
      ..rating = widget.capturingDatas['rating'].toDouble()
      ..town = widget.capturingDatas['town']
      ..department = widget.capturingDatas['department']
      ..detailedDescription = widget.capturingDatas['detailedDescription']
      ..moreInformation = widget.capturingDatas['moreInformation']
      ..latitude = widget.capturingDatas['latitude']
      ..longitude = widget.capturingDatas['longitude'];

    final box = Boxes.getFavoritesBox();
    //box.add(localSite);

    if (isFavorite){
      box.delete(localSite.id);
    } else{
      box.put(localSite.id, localSite);
    }

    setState(() {
      isFavorite = !isFavorite;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details of Site"),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
            },
            icon: const Icon(Icons.favorite),
          ),
          PopupMenuButton(
            onSelected: (Menu item){
              setState(() {
                if (item == Menu.logOut){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.logOut,
                child: Text('Sign out'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Center (
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  <Widget> [
                    Text(
                      widget.capturingDatas['nameSite'],
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.redAccent
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                        children:[
                          Expanded(
                              child: IconButton(
                                alignment: Alignment.topRight,
                                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                                color: Colors.red,
                                onPressed: ((){
                                  _onFavoritesButtonClicked();
                                }),
                              )
                          ),
                        ]
                    ),
                    Image(image: AssetImage(widget.capturingDatas['photo']),width: 250,),
                    Row(
                        children:[
                          Expanded(
                              child: IconButton(
                                alignment: Alignment.topRight,
                                icon: const Icon(Icons.location_on_outlined),
                                color: Colors.red,
                                onPressed: ((){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LocationPage(widget.capturingDatas)));
                                }),
                              )
                          ),
                        ]
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children:<Widget> [
                        const Text(
                          'TOWN: ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ),
                        ),
                        Text(
                          widget.capturingDatas['town'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.purple
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children:<Widget> [
                        const Text(
                          'DEPARTMENT : ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ),
                        ),
                        Text(
                          widget.capturingDatas['department'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.purple
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children:  const <Widget> [
                        Text(
                          'DESCRIPTION: ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ),
                        ),
                        Text(
                          'Esto es texto apoyo',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.capturingDatas['detailedDescription'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.purple
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children:  const <Widget> [
                        Text(
                          'MORE INFORMATION: ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ),
                        ),
                        Text(
                          'texto apoyo',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.capturingDatas['moreInformation'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.purple
                      ),
                    ),
                  ],
                )
            ),
          )
      ),
    );
  }
}