class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
     this.imgUrl= "https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2Fpcm98ZW58MHx8MHx8fDA%3D&w=1000&q=80",
  });
}

List<LocationItemModel> dummyLacations=[
  LocationItemModel(id: "1", city: "Cairo", country: "Egypt",),   
  LocationItemModel(id: "2", city: "Giza", country: "Egypt"),
  LocationItemModel(id: "3", city: "Alexanderia", country: "Egypt"),

];