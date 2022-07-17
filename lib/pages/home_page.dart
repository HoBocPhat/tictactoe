import 'package:caro_game/widgets/blank_space.dart';
import 'package:caro_game/widgets/user2_space.dart';
import 'package:flutter/material.dart';

import '../models/matrix.dart';
import '../models/position.dart';
import '../widgets/user1_space.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Position> user1Pos = [];
  List<Position> user2Pos = [];
  int number = 100;
  int count = 1;
  int scoreUser1 = 0;
  int scoreUser2 = 0;

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
  
  bool unDo(int x, int y, List<Position> positions){
    if(positions.last.x == x && positions.last.y == y){
      setState(() {
        positions.removeLast();
      });
      return true;
    }
    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "PLAYER 1 SCORE: $scoreUser1",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text("PLAYER 2 SCORE: $scoreUser2",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "PLAYER 1 SCORE: $scoreUser1",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text("PLAYER 2 SCORE: $scoreUser2",
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
                                          if(count == 2){
                                            if(unDo(x, y, user1Pos))
                                              {
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
                                          if(count == 1){
                                            if(unDo(x, y, user2Pos))
                                            {
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
                                                scoreUser1++;
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AlertDialog(
                                                      title: Text(
                                                          "Congratulation player 1"),
                                                    );
                                                  });
                                            }
                                          } else if (count == 2) {
                                            user2Play(x, y);
                                            bool isWin =
                                                winGame(x, y, user2Pos);
                                            if (isWin == true) {
                                                scoreUser2++;
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AlertDialog(
                                                      title: Text(
                                                          "Congratulation player 2"),
                                                    );
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
                child: Center(
              child: MaterialButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    user1Pos = [];
                    user2Pos = [];
                    count = 1;
                  });
                },
                child: const Text("PLAY AGAIN"),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
