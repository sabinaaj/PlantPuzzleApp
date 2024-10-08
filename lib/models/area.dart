// models/item.dart

class Area {
  int id;
  String title;

  Area({required this.id, required this.title});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      title: json['title'],
    );
  }
}
