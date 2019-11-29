class CreatedBy {
  String type;
  String name;
  String id;

  CreatedBy(this.type, this.name, this.id);

  CreatedBy.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'id': id,
      };
}

class Style {
  final String backgroundColor;

  Style(this.backgroundColor);

  Style.fromJson(Map<String, dynamic> json)
      : backgroundColor = json['backgroundColor'];

  Map<String, dynamic> toJson() => {'backgroundColor': backgroundColor};
}

class Widget {
  final String type;
  final String text;
  final Style style;
  CreatedBy createdBy;
  double y = -200.0;
  double x = -200.0;
  String id;

  Widget(this.type, this.text, this.style, this.x, this.y);

  Widget.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        text = json['text'],
        style = new Style.fromJson(json['style']),
        createdBy = new CreatedBy.fromJson(json['createdBy']),
        x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'style': style.toJson(),
        'x': x,
        'y': y,
      };
}
