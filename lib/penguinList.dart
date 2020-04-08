import './penguin.dart';

class PenguinList {
  final List<Penguin> penguins;

  PenguinList({ this.penguins });

  factory PenguinList.fromJson(List<dynamic> parsedJson) {
    return new PenguinList(
      penguins: parsedJson.map(
        (p) => Penguin.fromJson(p)
      ).toList()
    );
  }
}