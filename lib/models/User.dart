class User {
  String type;
  String name;
  String id;

  User(this.type, this.name, this.id);

  User.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'id': id,
      };
}
