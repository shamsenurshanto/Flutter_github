// To parse this JSON data, do
//
//     final dataListFromGitIssues = dataListFromGitIssuesFromJson(jsonString);

import 'dart:convert';

List<DataListFromGitIssues> dataListFromGitIssuesFromJson(String str) => List<DataListFromGitIssues>.from(json.decode(str).map((x) => DataListFromGitIssues.fromJson(x)));

String dataListFromGitIssuesToJson(List<DataListFromGitIssues> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataListFromGitIssues {
 
  String title;
  User user;
  List<Label> labels;

  DateTime createdAt;
  
  String? body;
 

  DataListFromGitIssues({
  
    required this.title,
    required this.user,
    required this.labels,
 
    required this.createdAt,
   
    required this.body,

  });

  factory DataListFromGitIssues.fromJson(Map<String, dynamic> json) => DataListFromGitIssues(
       
        title: json["title"],
        user: User.fromJson(json["user"]),
        labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
       
        createdAt: DateTime.parse(json["created_at"]),
       
        body: json["body"],
       
      );

  Map<String, dynamic> toJson() => {
        
        "title": title,
        "user": user?.toJson(),
        "labels": List<dynamic>.from(labels!.map((x) => x.toJson())),
       
        "created_at": createdAt.toIso8601String(),
     
        "body": body,
      
      };
}

class User {
  String login;
  

  User({
    required this.login,
   
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
      
      );

  Map<String, dynamic> toJson() => {
        "login": login,
       
      };
}

enum Type { USER }

final typeValues = EnumValues({"User": Type.USER});

enum AuthorAssociation { CONTRIBUTOR, MEMBER, NONE }

final authorAssociationValues = EnumValues({"CONTRIBUTOR": AuthorAssociation.CONTRIBUTOR, "MEMBER": AuthorAssociation.MEMBER, "NONE": AuthorAssociation.NONE});

class Label {

  String? name;


  Label({
   
    required this.name,
  
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
     
        name: json["name"],
   
      );

  Map<String, dynamic> toJson() => {
     
        "name": name,
       
      };
}


enum State { OPEN }

final stateValues = EnumValues({"open": State.OPEN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
