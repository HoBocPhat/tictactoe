
import 'package:caro_game/commons/widgets/high_score_tile.dart';
import 'package:caro_game/commons/widgets/custom_dialog.dart';
import 'package:caro_game/commons/widgets/submit_button.dart';
import 'package:caro_game/modules/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:caro_game/commons/widgets/blank_space.dart';
import 'package:caro_game/commons/widgets/user1_space.dart';
import 'package:caro_game/commons/widgets/user2_space.dart';
import 'package:caro_game/models/position.dart';


class PlayPage extends StatefulWidget {
  final String namePlayer1;
  final String namePlayer2;
  const PlayPage({Key? key, required this.namePlayer1, required this.namePlayer2}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late ConfettiController confettiController;
  final assetsAudioPlayer = AssetsAudioPlayer();
  List<Position> user1Pos = [];
  List<Position> user2Pos = [];
  int number = 100;
  int count = 1;
  int scoreUser1 = 0;
  int scoreUser2 = 0;


  void submitScore () {
    var database = FirebaseFirestore.instance;
    database.collection("scores").add({
      "name": widget.namePlayer1,
      "score": scoreUser1}
    );
    database.collection("scores").add({
      "name": widget.namePlayer2,
      "score": scoreUser2}
    );
  }

  void playAudio (AssetsAudioPlayer assetsAudioPlayer) async{
    await assetsAudioPlayer.open(Audio('assets/audios/cheer.mp3'));
  }

  void user1Play(int x, int y) {
    setState(() {
      user1Pos.add(Position(x, y));
    });
    count = 2;
  }

  void user2Play(int x, int y) {
    setState(() {
      user2Pos.add(Position(x, y));
    });
    count = 1;
  }

  bool winGame(int x, int y, List<Position> positions) {
    int w = 0;
    int k = x;
    int h = y;
    //kiem tra hang
    while (positions.any((e) => e.x == k && e.y == y)) {
      w++;
      k++;
    }
    k = x - 1;
    while (positions.any((e) => e.x == k && e.y == y)) {
      w++;
      k--;
    }
    if (w > 4) {
      return true;
    }
    //kiem tra cot
    w = 0;
    while (positions.any((e) => e.x == x && e.y == h)) {
      w++;
      h++;
    }
    h = y - 1;
    while (positions.any((e) => e.x == x && e.y == h)) {
      w++;
      h--;
    }
    if (w > 4) {
      return true;
    }
    //kiem tra duong cheo 1
    k = x;
    h = y;
    w = 0;
    while (positions.any((e) => e.x == k && e.y == h)) {
      w++;
      k++;
      h++;
    }
    k = x - 1;
    h = y - 1;
    while (positions.any((e) => e.x == k && e.y == h)) {
      w++;
      k--;
      h--;
    }
    if (w > 4) {
      return true;
    }
    k = x;
    h = y;
    w = 0;
    //kiem tra duong cheo 2
    while (positions.any((e) => e.x == k && e.y == h)) {
      w++;
      k++;
      h--;
    }
    k = x - 1;
    h = y + 1;
    while (positions.any((e) => e.x == k && e.y == h)) {
      w++;
      k--;
      h++;
    }
    if (w > 4) {
      return true;
    }
    return false;
  }

  bool unDo(int x, int y, List<Position> positions) {
    if (positions.last.x == x && positions.last.y == y) {
      setState(() {
        positions.removeLast();
      });
      return true;
    }
    return false;
  }

  @override
  void initState() {
    confettiController = ConfettiController();
    //confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                    child: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${widget.namePlayer1} SCORE: $scoreUser1",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text("${widget.namePlayer2} SCORE: $scoreUser2",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white))
                              ],
                            ),
                        )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${widget.namePlayer1} SCORE: $scoreUser1",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text("${widget.namePlayer2} SCORE: $scoreUser2",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          )),
                Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Row(
                          children: List.generate(
                              number,
                              (x) => Column(
                                    children: List.generate(number, (y) {
                                      if (user1Pos
                                          .any((e) => e.x == x && e.y == y)) {
                                        return GestureDetector(
                                            onTap: () {
                                              if (count == 2) {
                                                if (unDo(x, y, user1Pos)) {
                                                  count = 1;
                                                }
                                              }
                                            },
                                            child: const User1Space());
                                      }
                                      if (user2Pos
                                          .any((e) => e.x == x && e.y == y)) {
                                        return GestureDetector(
                                            onTap: () {
                                              if (count == 1) {
                                                if (unDo(x, y, user2Pos)) {
                                                  count = 2;
                                                }
                                              }
                                            },
                                            child: const User2Space());
                                      } else {
                                        return GestureDetector(
                                            onTap: () {
                                              if (count == 1) {
                                                user1Play(x, y);
                                                bool isWin =
                                                    winGame(x, y, user1Pos);
                                                if (isWin == true) {
                                                  playAudio(assetsAudioPlayer);
                                                  confettiController.play();
                                                  scoreUser1++;
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return CustomDialog(name: widget.namePlayer1);
                                                      });
                                                }
                                              } else if (count == 2) {
                                                user2Play(x, y);
                                                bool isWin =
                                                    winGame(x, y, user2Pos);
                                                if (isWin == true) {
                                                  playAudio(assetsAudioPlayer);
                                                  confettiController.play();
                                                  scoreUser2++;
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return CustomDialog(name: widget.namePlayer2);
                                                      });
                                                }
                                              }
                                            },
                                            child: const BlankSpace());
                                      }
                                    }),
                                  )),
                        ),
                      ),
                    )),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SubmitButton(
                        label: "PLAY AGAIN",
                        submit: () {
                          confettiController.stop();
                          setState(() {
                            user1Pos = [];
                            user2Pos = [];
                            count = 1;
                          });
                        },
                      ),
                        SubmitButton(label: "SAVE SCORE", submit: (){
                          submitScore();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=> const WelcomePage()));
                        })
                      ],
                    ))
              ],
            ),
            ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
            )
          ],
        ),
      ),
    );
  }
}
