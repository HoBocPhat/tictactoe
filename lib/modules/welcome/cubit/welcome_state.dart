import 'package:equatable/equatable.dart';

abstract class WelcomeState extends Equatable{

}

class WelcomeInitial extends WelcomeState{
  @override
  List<Object?> get props => [];

}

class HighScoreLoaded extends WelcomeState{
  final List<String> data;

  @override
  // TODO: implement props
  List<Object?> get props => [data];

  HighScoreLoaded(this.data);
}

class WelcomeError extends WelcomeState{
  final String err;

  @override
  // TODO: implement props
  List<Object?> get props => [err];

  WelcomeError(this.err);
}