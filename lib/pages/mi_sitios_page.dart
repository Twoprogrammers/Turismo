import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'new_Site_page.dart';

class MySitePage extends StatefulWidget {
  const MySitePage({Key? key}) : super(key: key);

  @override
  State<MySitePage> createState() => _MySitePageState();
}

enum Menu { logOut }

class _MySitePageState extends  State<MySitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection("sitios")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading');
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot book = snapshot.data!.docs[index];
                  return Card(
                      child: ListTile(
                        title: Text(book['name']),
                        subtitle: Text(book['localizacion']),
                      ));
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewSitePage()));
          },
          tooltip: 'Nuevo Lugar',
          child: const Icon(Icons.add)),
    );
  }
}
