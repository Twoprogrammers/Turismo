import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../boxes.dart';
import '../models/local_site.dart';
import 'detailsfavorites_page.dart';
import 'home_page.dart';
import 'login_page.dart';
class FavoritesPage extends StatefulWidget {

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

enum Menu{logOut}
double _rating = 3.0;

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite Sites"),
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
            child: Center(
              child: _buildListView(),
            )
        )
    );
  }

  Widget _buildListView(){
    return ValueListenableBuilder<Box<dynamic>>(
        valueListenable: Boxes.getFavoritesBox().listenable(),
        builder: (context, box, _){
          final siteBox = box.values.toList().cast<LocalSite>();
          return ListView.builder(
            itemCount: siteBox.length,
            itemBuilder: (context, index) {
              final site = siteBox[index];
              return Card(
                child: ListTile(
                  leading: Image(image: AssetImage(site.photo ?? "No Image"),width: 50,),
                  title: Text(site.nameSite ?? "No title"),
                  subtitle: Column(
                      children: <Widget>[
                        Text(site.generalDescription ?? "No description"),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RatingBar.builder(
                              initialRating: site.rating?? 3,
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
                  onLongPress: (){
                    setState(() {
                      site.delete();
                    });
                  },
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  enabled: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsFavoritesPage(site)));
                  },
                ),
              );
            },
          );
        }
    );
  }
}