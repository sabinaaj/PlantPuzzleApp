
class Area {
  final int id;
  final String title;
  final String? iconUrl;

  Area({required this.id, required this.title, this.iconUrl});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      title: json['title'],
      iconUrl: json['icon_url'], 
    );
  }
}
