import 'package:caro_game/app/cubit/app_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HighScoreTile extends StatelessWidget {
  final String documentId;
  const HighScoreTile({Key? key, required this.documentId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = context.read<AppCubit>();
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
                Text(data['name'], style: appCubit.styles.defaultHeadlineStyle()),
                Text(data['score'].toString(), style:  appCubit.styles.defaultHeadlineStyle())
              ],
            );
          } else{
            return Text("Loading ...", style: appCubit.styles.defaultHeadlineStyle());
          }

      }
    );
  }
}
