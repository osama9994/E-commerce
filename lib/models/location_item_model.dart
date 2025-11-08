// class LocationItemModel {
//   final String id;
//   final String city;
//   final String country;
//   final String imgUrl;
//   final bool isChosen;

//   LocationItemModel({
//     required this.id,
//     required this.city,
//     required this.country,
//     this.imgUrl =
//         "https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2Fpcm98ZW58MHx8MHx8fDA%3D&w=1000&q=80",
//     this.isChosen = false,
//   });

//   LocationItemModel copyWith({
//     String? id,
//     String? city,
//     String? country,
//     String? imgUrl,
//     bool? isChosen,
//   }) {
//     return LocationItemModel(
//       id: id ?? this.id,
//       city: city ?? this.city,
//       country: country ?? this.country,
//       imgUrl: imgUrl ?? this.imgUrl,
//       isChosen: isChosen ?? this.isChosen,
//     );
//   }
// }

// List<LocationItemModel> dummyLacations = [
//   LocationItemModel(id: "1", city: "Cairo", country: "Egypt"),
//   LocationItemModel(id: "2", city: "Giza", country: "Egypt"),
//   LocationItemModel(id: "3", city: "Alexanderia", country: "Egypt"),
// ];
class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isChosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl =
        "https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2Fpcm98ZW58MHx8MHx8fDA%3D&w=1000&q=80",
    this.isChosen = false,
  });

  // نسخة جديدة معدّلة من النموذج
  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isChosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  // ✅ حماية إضافية ضد النصوص الفارغة
  String get safeCity => city.isNotEmpty ? city : "Unknown City";
  String get safeCountry => country.isNotEmpty ? country : "Unknown Country";
}

List<LocationItemModel> dummyLacations = [
  LocationItemModel(id: "1", city: "Cairo", country: "Egypt"),
  LocationItemModel(id: "2", city: "Giza", country: "Egypt"),
  LocationItemModel(id: "3", city: "Alexandria", country: "Egypt"),
];
