import 'package:caro_game/commons/widgets/submit_button.dart';
import 'package:caro_game/commons/widgets/text_input.dart';
import 'package:caro_game/modules/play/play_page.dart';
import 'package:caro_game/modules/welcome/cubit/welcome_cubit.dart';
import 'package:caro_game/modules/welcome/cubit/welcome_state.dart';
import 'package:caro_game/repository/welcome_repo.dart';
import 'package:flutter/material.dart';

import 'package:caro_game/commons/widgets/high_score_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:caro_game/app/cubit/app_cubit.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static const _gap = SizedBox(height: 10);
  late TextEditingController namePlayer1Controller;
  late TextEditingController namePlayer2Controller;
  List<String> highScoreDocIds = [];
  late WelcomeCubit welcomeCubit;
  late WelcomeRepository welcomeRepository;
  late AppCubit appCubit;

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    namePlayer1Controller = TextEditingController();
    namePlayer2Controller = TextEditingController();
    welcomeRepository = WelcomeRepository();
    welcomeCubit = WelcomeCubit(welcomeRepository);
    super.initState();
  }

  @override
  void dispose() {
    namePlayer1Controller.dispose();
    namePlayer2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCubit.styles.themeData?.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Transform.rotate(
                angle: -0.1,
                child: Text(
                  'Tic Tac Toe Game',
                  textAlign: TextAlign.center,
                  style: appCubit.styles.defaultTitleStyle()
                ),
              ),
              _gap,
              SubmitButton(label: "Play", submit: (){
                showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                        backgroundColor: appCubit.styles.themeData?.backgroundColor,
                        content: Form(
                          child: SizedBox(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextInput(labelText: "Name Player 1", controller: namePlayer1Controller),
                                    const SizedBox(height: 20),
                                    TextInput(labelText: "Name Player 2", controller: namePlayer2Controller),
                                    const SizedBox(height: 20),
                                    Center(
                                        child: SubmitButton(
                                          label: "PLAY",
                                          submit: (){
                                            Navigator.pop(context);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)
                                            => PlayPage(namePlayer1: namePlayer1Controller.text,
                                                namePlayer2: namePlayer2Controller.text)));
                                          },
                                        )
                                    )
                                  ],
                                ),
                              ),
                          ),
                        ),
                      );
                });
              }
              ),
              _gap,
              SubmitButton(label: "High Scores", submit: (){
                welcomeCubit.getHighScoreIds();
                showDialog(context: context, builder: (context){
                  return Dialog(
                    backgroundColor: appCubit.styles.themeData?.backgroundColor,
                    child: BlocConsumer<WelcomeCubit,WelcomeState>(
                        bloc: welcomeCubit,
                        listener : (context, state){
                          if(state is HighScoreLoaded){
                            highScoreDocIds = state.data;
                          }
                        },
                        builder: (context, state){
                          return
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ListView.separated(
                                    separatorBuilder: (context, index){
                                      return const SizedBox(height: 30);

                                    },
                                    shrinkWrap: true,
                                    itemCount: highScoreDocIds.length,
                                    itemBuilder: (context, index) {
                                      if(index == 0){
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("Name", style: appCubit.styles.defaultHeadlineStyle()),
                                                Text("Score", style: appCubit.styles.defaultHeadlineStyle())
                                              ],
                                            ),
                                            const SizedBox(height: 30),
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
              }),
              _gap,
              SubmitButton(label: "Change Theme", submit: (){
                appCubit.changeStyle();
              }),
            ],
          ),
        ),
      )
    );
  }
}
