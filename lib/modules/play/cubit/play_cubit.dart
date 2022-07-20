import 'package:caro_game/models/position.dart';
import 'package:caro_game/modules/play/cubit/play_state.dart';
import 'package:caro_game/repository/play_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:caro_game/models/score.dart';

class PlayCubit extends Cubit<PlayState>{
  final PlayRepository repo;
  PlayCubit(this.repo) : super(PlayInitial());

  Future playAudio () async {
    try{
      await repo.playAudio();
    } catch(err){
      emit(PlayError("Can't play audio"));
    }
  }

  Future submitScore(List<Score> data) async {
    try{
      await repo.submitScore(data);
    } catch(err){
      emit(PlayError("Can't submit scores"));
    }
  }

  bool unDo (int x, int y, List<Position> pos)  {
    try{
      emit(UndoLoading());
      bool isDone = false;
      List<Position> positions = repo.unDo(x, y, pos, isDone);
      emit(UnDoLoaded(positions));
      return isDone;
    } catch(err) {
      emit(PlayError("Can't undo the move"));
      return false;
    }
  }

  bool winGame(int x, int y, List<Position> positions) {
    return repo.winGame(x, y, positions);
  }

}