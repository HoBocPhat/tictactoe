import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HighScoreTile extends StatelessWidget {
  final String documentId;
  const HighScoreTile({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference highscores = FirebaseFirestore.instance.collection('scores');
    return FutureBuilder<DocumentSnapshot>(
        future: highscores.doc(documentId).get(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data['name'], style: TextStyle(fontSize: 20),),
                Text(data['score'].toString(), style: TextStyle(fontSize: 20),)
              ],
            );
          } else{
            return Text("Loading ...");
          }

      }
    );
  }
}
