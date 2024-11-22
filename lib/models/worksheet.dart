
class Worksheet {
  final int id;
  final String title;

  Worksheet({required this.id, required this.title});

  factory Worksheet.fromJson(Map<String, dynamic> json) {
    return Worksheet(
      id: json['id'],
      title: json['title'],
    );
  }
}
