class LocationModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isSelected;

  LocationModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl = "https://cdn-icons-png.flaticon.com/128/854/854878.png",
    this.isSelected = false,
  });

  LocationModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isSelected,
  }) {
    return LocationModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      imgUrl: map['imgUrl'] as String? ??
          "https://cdn-icons-png.flaticon.com/128/854/854878.png",
      isSelected: map['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'country': country,
      'imgUrl': imgUrl,
      'isSelected': isSelected,
    };
  }
  
}

