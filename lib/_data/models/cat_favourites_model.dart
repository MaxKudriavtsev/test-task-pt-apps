import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';

class CatFavouriteModel {
  final int id;
  final String imageId;
  final String? subId;
  final DateTime createdAt;
  final CatImageModel image;

  CatFavouriteModel({
    required this.id,
    required this.imageId,
    this.subId,
    required this.createdAt,
    required this.image,
  });

  factory CatFavouriteModel.fromJson(Map<String, dynamic> json) {
    return CatFavouriteModel(
      id: json['id'],
      imageId: json['image_id'],
      subId: json['sub_id'],
      createdAt: DateTime.parse(json['created_at']),
      image: CatImageModel.fromJson(json['image']),
    );
  }
}
