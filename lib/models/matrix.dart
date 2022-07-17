
import 'package:caro_game/models/position.dart';

class Matrix {
  final int id;
  final List<Position> positions;
  Matrix(this.id, this.positions);

  Matrix add (int id, Position position) {
    positions.add(position);
    return Matrix(this.id, positions);
  }
}