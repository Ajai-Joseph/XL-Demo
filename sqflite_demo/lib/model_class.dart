class ModelClass {
  int id;
  String name;
  int age;

  ModelClass({
    required this.id,
    required this.name,
    required this.age,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
        id: json["id"],
        name: json["name"],
        age: json["age"],
      );
}
