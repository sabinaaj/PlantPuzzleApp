
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

class Plant {
  final int id;
  final String name;
  final List<PlantImage> images; 

  Plant({
    required this.id,
    required this.name,
    this.images = const [],
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      images: (json['images'] as List)
          .map((imageJson) => PlantImage.fromJson(imageJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': images.map((img) => img.toJson()).toList(),
    };
  }
}

class PlantImage {
  final int id;
  final String image;

  PlantImage({
    required this.id,
    required this.image,
  });

  factory PlantImage.fromJson(Map<dynamic, dynamic> json) {
    return PlantImage(
      id: json['id'],
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': image,
    };
  }
}