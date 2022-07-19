import 'package:caro_game/commons/widgets/submit_button.dart';
import 'package:caro_game/commons/widgets/text_input.dart';
import 'package:caro_game/modules/play/play_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:caro_game/commons/widgets/high_score_tile.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static const _gap = SizedBox(height: 10);
  late TextEditingController namePlayer1Controller;
  late TextEditingController namePlayer2rController;
  List<String> highScoreDocIds = [];
  late final Future? getDocIds;

  Future getDocId() async{
    await FirebaseFirestore.instance
        .collection("scores")
        .orderBy("score", descending: true)
        .limit(5)
        .get()
        .then((value) => value.docs.forEach((element) {
      highScoreDocIds.add(element.reference.id);
    }));
  }

  @override
  void initState() {
    namePlayer1Controller = TextEditingController();
    namePlayer2rController = TextEditingController();
    getDocIds = getDocId();
    super.initState();
  }

  @override
  void dispose() {
    namePlayer1Controller.dispose();
    namePlayer2rController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -0.1,
            child: const Text(
              'Tic Tac Toe Game',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
              ),
            ),
          ),
          _gap,
          SubmitButton(label: "Play", submit: (){
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                content: Form(
                  child: SizedBox(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        TextInput(labelText: "Name Player 1", controller: namePlayer1Controller),
                        const SizedBox(height: 20),
                        TextInput(labelText: "Name Player 2", controller: namePlayer2rController)
                      ],
                    ),
                  ),
                ),
                actions: [
                  Center(
                      child: SubmitButton(
                        label: "PLAY",
                        submit: (){
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                          => PlayPage(namePlayer1: namePlayer1Controller.text,
                              namePlayer2: namePlayer2rController.text)));
                        },
                      )
                  )
                ],
              );
            });
          }
          ),
          _gap,
          SubmitButton(label: "Setting", submit: (){
          }),
          _gap,
          SubmitButton(label: "High Scores", submit: (){
            showDialog(context: context, builder: (context){
              return Dialog(
                child: FutureBuilder(
                    future: getDocIds,
                    builder: (context, snapshot){
                      return
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: highScoreDocIds.length,
                                itemBuilder: (context, index) {
                                  if(index == 0){
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Name", style: TextStyle(fontSize: 20),),
                                            Text("Score", style: TextStyle(fontSize: 20),)
                                          ],
                                        ),
                                        HighScoreTile(documentId: highScoreDocIds[index])
                                      ],
                                    );
                                  }
                                  else{
                                    return HighScoreTile(documentId: highScoreDocIds[index]);
                                  }
                                }),
                          );
                    })
              );
            });
          })
        ],
      )
    );
  }
}
