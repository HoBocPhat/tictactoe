
import 'package:equatable/equatable.dart';

import 'package:caro_game/models/position.dart';

abstract class PlayState extends Equatable{

}

class PlayInitial extends PlayState{
  @override
  List<Object?> get props => [];

}

class UndoLoading extends PlayState{
  @override
  List<Object?> get props => [];

}

class UnDoLoaded extends PlayState{
  final List<Position> pos;

  @override
  // TODO: implement props
  List<Object?> get props => [pos];

  UnDoLoaded(this.pos);

}

class PlayError extends PlayState{
  final String err;

  @override
  List<Object?> get props => [];

  PlayError(this.err);
}