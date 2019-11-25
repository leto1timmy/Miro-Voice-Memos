import 'dart:convert' show jsonDecode;
import 'dart:io';

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

void main(List<String> args) {
  var jsonString = new File('./boards.json').readAsStringSync();
  Map usersMap = jsonDecode(jsonString);

  List<Board> boards = new List<Board>();
  var userlist = usersMap['data'];
  userlist.forEach((el) {
    boards.add(Board.fromJson(el));
  });

  var board = boards[0];

  print('name, ${board.name}!');
  print('title, ${board.description}.');
  print('created at, ${board.createdAt}');
}
