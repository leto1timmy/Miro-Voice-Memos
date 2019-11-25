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
  var scale;
  var y;
  var x;
  var id;

  Widget(this.type, this.text, this.style);

  Widget.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        text = json['text'],
        style = new Style.fromJson(json['style']),
        scale = json['scale'],
        x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'style': style.toJson(),
      };
}
