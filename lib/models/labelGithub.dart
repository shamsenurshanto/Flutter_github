// To parse this JSON data, do
//
//     final LabelGithub = LabelGithubFromJson(jsonString);

import 'dart:convert';

List<LabelGithub> LabelGithubFromJson(String str) => List<LabelGithub>.from(json.decode(str).map((x) => LabelGithub.fromJson(x)));

String LabelGithubToJson(List<LabelGithub> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LabelGithub {
  int id;
  String nodeId;
  String url;
  String name;
  Color color;
  bool LabelGithubDefault;
  String description;

  LabelGithub({
    required this.id,
    required this.nodeId,
    required this.url,
    required this.name,
    required this.color,
    required this.LabelGithubDefault,
    required this.description,
  });

  factory LabelGithub.fromJson(Map<String, dynamic> json) => LabelGithub(
        id: json["id"],
        nodeId: json["node_id"],
        url: json["url"],
        name: json["name"],
        color: colorValues.map[json["color"]]!,
        LabelGithubDefault: json["default"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "node_id": nodeId,
        "url": url,
        "name": name,
        "color": colorValues.reverse[color],
        "default": LabelGithubDefault,
        "description": description,
      };
}

enum Color { FFFFFF, THE_38_D8_C8 }

final colorValues = EnumValues({"ffffff": Color.FFFFFF, "38d8c8": Color.THE_38_D8_C8});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
