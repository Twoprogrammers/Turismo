import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/local_site.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'location_favorites_page.dart';
import 'login_page.dart';

class DetailsFavoritesPage extends StatefulWidget {
  LocalSite localSite;

  DetailsFavoritesPage(this.localSite,{super.key});


  @override
  State<DetailsFavoritesPage> createState() => _DetailsFavoritesPageState();
}

enum Menu{logOut}

class _DetailsFavoritesPageState extends State<DetailsFavoritesPage> {
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
                      widget.localSite.nameSite ?? "No Name",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.redAccent
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Image(image: AssetImage(widget.localSite.photo ?? "assets/images/logo.png"),width: 250,),
                    Row(
                        children:[
                          Expanded(
                              child: IconButton(
                                alignment: Alignment.topRight,
                                icon: const Icon(Icons.location_on_outlined),
                                color: Colors.red,
                                onPressed: ((){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationFavoritesPage(widget.localSite)));
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
                          widget.localSite.town ?? "No town",
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
                          widget.localSite.department ?? "No Department",
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
                      widget.localSite.detailedDescription ?? "No Description",
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
                      widget.localSite.moreInformation ?? "No information",
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