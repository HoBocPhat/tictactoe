
import 'package:caro_game/modules/welcome/cubit/welcome_state.dart';
import 'package:caro_game/repository/welcome_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeCubit extends Cubit<WelcomeState>{
  final WelcomeRepository repo;

  WelcomeCubit(this.repo) : super(WelcomeInitial());

  Future<List<String>> getHighScoreIds () async{
    List<String> ids = [];
    try{
      emit(HighScoreLoading());
      ids = await repo.getDocId();
      emit(HighScoreLoaded(ids));
    } catch (err){
      emit(WelcomeError("Can't get ID from Database"));
    }
    return ids;
  }

}