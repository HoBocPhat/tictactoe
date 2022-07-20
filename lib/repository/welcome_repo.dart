
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeRepository{

  CollectionReference database = FirebaseFirestore.instance.collection('scores');

  Future<List<String>> getDocId() async{
    List<String> highScoreDocIds = [];
    await database.orderBy("score", descending: true).limit(5).get()
        .then((value) => value.docs.forEach((element) {
          highScoreDocIds.add(element.reference.id);
    }));
    return highScoreDocIds;
  }
}