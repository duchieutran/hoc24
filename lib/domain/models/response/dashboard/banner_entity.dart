// To parse this JSON data, do
//
//     final subjectEntity = subjectEntityFromJson(jsonString);

class BannerEntity {
  String? image;
  String? route;

  BannerEntity({
    this.image,
    this.route,
  });

  factory BannerEntity.fromJson(Map<String, dynamic> json) => BannerEntity(
        image: json["image"],
        route: json["route"],
      );
}
