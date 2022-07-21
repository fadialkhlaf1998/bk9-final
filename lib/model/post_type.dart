import 'dart:convert';

class PostTypeDecoder {
  PostTypeDecoder({
    required this.postTypes,
  });

  List<PostType> postTypes;

  factory PostTypeDecoder.fromJson(String str) => PostTypeDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostTypeDecoder.fromMap(Map<String, dynamic> json) => PostTypeDecoder(
    postTypes: List<PostType>.from(json["post_types"].map((x) => PostType.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "post_types": List<dynamic>.from(postTypes.map((x) => x.toMap())),
  };
}

class PostType {
  PostType({
    required this.id,
    required this.name,
    required this.companyId,
  });

  int id;
  String name;
  int companyId;

  factory PostType.fromJson(String str) => PostType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostType.fromMap(Map<String, dynamic> json) => PostType(
    id: json["id"],
    name: json["name"],
    companyId: json["company_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "company_id": companyId,
  };
}
