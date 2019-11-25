class Board {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final String modifiedAt;

  Board(this.id, this.name, this.description, this.createdAt, this.modifiedAt);

  Board.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        createdAt = json['createdAt'],
        modifiedAt = json['modifiedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'createdAt': createdAt,
        'modifiedAt': modifiedAt
      };
}
