import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'details_page.dart';
import 'favorites_page.dart';
import 'login_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Menu{logOut}
double _rating = 3.0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourist Sites"),
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("places").snapshots(),
              builder: (context, snapshot){
                if (snapshot.hasError) {return const Text('Something went wrong');}
                if (!snapshot.hasData) return const Text('Loading');
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot site = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        leading: Image(image: AssetImage(site['photo']), width: 50,),
                        title: Text(site['nameSite']),
                        subtitle:
                        Column(
                            children: <Widget>[
                              Text(site['generalDescription']),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RatingBar.builder(
                                    initialRating: site['rating'].toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemSize: 16.0,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.purpleAccent,
                                    ),
                                    onRatingUpdate: (rating){
                                      _rating = rating;
                                    }
                                ),
                              )
                            ]
                        ),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        enabled: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(site)));
                        },
                      ),
                    );
                  },
                );
              }
          )
      ),
    );
  }
}