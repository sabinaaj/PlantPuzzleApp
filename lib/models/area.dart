// models/item.dart

class Area {
  String title;

  Area({required this.title});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      title: json['title'],
    );
  }
}
