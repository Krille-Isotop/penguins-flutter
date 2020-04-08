class Penguin {
  final String breed;
  final int id;

  Penguin({ this.breed, this.id });

  factory Penguin.fromJson(Map<String, dynamic> json) {
    return Penguin(
      breed: json['breed'],
      id: json['id']
    );
  }
}
