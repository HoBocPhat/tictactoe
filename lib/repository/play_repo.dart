import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:caro_game/models/score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:caro_game/models/position.dart';

class PlayRepository {

  final assetsAudioPlayer = AssetsAudioPlayer();
  CollectionReference database = FirebaseFirestore.instance.collection('scores');

  Future<void> playAudio () async{
    await assetsAudioPlayer.open(Audio('assets/audios/cheer.mp3'));
  }

  Future<void> submitScore(List<Score> data) async{
    await database.add({"name": data[0].name, "score": data[0].score});
    await database.add({"name": data[1].name, "score": data[1].score});
  }

  List<Position> unDo(int x, int y, List<Position> positions, bool isDone){
    if (positions.last.x == x && positions.last.y == y) {
        positions.removeLast();
        isDone = true;
    }
    isDone = false;
    return positions;
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
}