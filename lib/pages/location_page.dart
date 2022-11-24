
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'favorites_page.dart';
import 'home_page.dart';
import 'login_page.dart';

class LocationPage extends StatefulWidget {
  late QueryDocumentSnapshot capturingDatas2;

  LocationPage(this.capturingDatas2,{super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

enum Menu{logOut}

class _LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = Set<Marker>();

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  @override
  void dispose(){
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Location of Site"),
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
        body:
        Stack(
            children :[

              GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.capturingDatas2['latitude'], widget.capturingDatas2['longitude']),
                  zoom: 15,
                ),
                markers: _markers,
                onTap: (position){
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
                onMapCreated: (GoogleMapController controller) async {
                  _customInfoWindowController.googleMapController = controller;
                  //_controller.complete(controller);
                  _showMarker();
                },
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 225,
                width: 155,
                offset: 50,
              )
            ]
        )
    );
  }

  void _showMarker(){
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(widget.capturingDatas2['nameSite']),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(widget.capturingDatas2['latitude'], widget.capturingDatas2['longitude']),
        /*infoWindow: InfoWindow(
          title: widget.capturingDatas2['nameSite'],
          snippet: "Description: ${widget.capturingDatas2['generalDescription']}"
        ),*/
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:Border.all(color:Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 9.0,),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:AssetImage(widget.capturingDatas2['photo']),
                                //fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            //color: Colors.purple,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        widget.capturingDatas2['nameSite'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Text(
                        widget.capturingDatas2['generalDescription'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 3.0,),
                  ],
                ),
              ),
              LatLng(widget.capturingDatas2['latitude'], widget.capturingDatas2['longitude'])
          );
        },
      ));
    });
  }
}
