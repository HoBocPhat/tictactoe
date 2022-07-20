
import 'package:caro_game/app/cubit/app_cubit.dart';
import 'package:caro_game/commons/widgets/high_score_tile.dart';
import 'package:caro_game/commons/widgets/custom_dialog.dart';
import 'package:caro_game/commons/widgets/submit_button.dart';
import 'package:caro_game/modules/play/cubit/play_cubit.dart';
import 'package:caro_game/modules/play/cubit/play_state.dart';
import 'package:caro_game/modules/welcome/welcome_page.dart';
import 'package:caro_game/repository/play_repo.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:caro_game/commons/widgets/blank_space.dart';
import 'package:caro_game/commons/widgets/user1_space.dart';
import 'package:caro_game/commons/widgets/user2_space.dart';
import 'package:caro_game/models/position.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/score.dart';


class PlayPage extends StatefulWidget {
  final String namePlayer1;
  final String namePlayer2;
  const PlayPage({Key? key, required this.namePlayer1, required this.namePlayer2}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late AppCubit appCubit;
  late ConfettiController confettiController;
  late PlayCubit playCubit;
  late PlayRepository playRepository;
  List<Position> pos = [];
  List<Position> user1Pos = [];
  List<Position> user2Pos = [];
  int number = 100;
  int count = 1;
  int scoreUser1 = 0;
  int scoreUser2 = 0;
  List<Score> scores = [];

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
    appCubit = context.read<AppCubit>();
    confettiController = ConfettiController();
    playRepository = PlayRepository();
    playCubit = PlayCubit(playRepository);
    //confettiController.play();
    super.initState();
  }

  @override
  void dispose() {

    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: appCubit.styles.backgroundContainer()),
        backgroundColor: appCubit.styles.themeData?.backgroundColor,
      ),
      backgroundColor: appCubit.styles.themeData?.backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                    child: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${widget.namePlayer1} SCORE: $scoreUser1",
                                style: appCubit.styles.defaultHeadlineStyle(),
                              ),
                              Text("${widget.namePlayer2} SCORE: $scoreUser2",
                                  style: appCubit.styles.defaultHeadlineStyle())
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${widget.namePlayer1} SCORE: $scoreUser1",
                                style: appCubit.styles.defaultHeadlineStyle(),
                              ),
                              Text("${widget.namePlayer2} SCORE: $scoreUser2",
                                  style: appCubit.styles.defaultHeadlineStyle())
                            ],
                          )),
                Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child:  Row(
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
                                          return BlocBuilder<PlayCubit,PlayState>(
                                            bloc: playCubit,
                                            builder: (context, state) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    if (count == 1) {
                                                      user1Play(x, y);
                                                      bool isWin =
                                                          playCubit.winGame(x, y, user1Pos);
                                                      if (isWin == true) {
                                                        playCubit.playAudio();
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
                                                          playCubit.winGame(x, y, user2Pos);
                                                      if (isWin == true) {
                                                        playCubit.playAudio();
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
                                          );
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
                        BlocBuilder<PlayCubit, PlayState>(
                          bloc: playCubit,
                          builder: (context, state) {
                            return SubmitButton(label: "SAVE SCORE", submit: (){
                              scores.add(Score(widget.namePlayer1, scoreUser1));
                              scores.add(Score(widget.namePlayer2, scoreUser2));
                              playCubit.submitScore(scores);
                              Navigator.pop(context);
                            });
                          }
                        )
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
