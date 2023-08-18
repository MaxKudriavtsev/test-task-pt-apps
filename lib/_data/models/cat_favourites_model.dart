import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';

class CatFavouriteModel {
  final int id;
  final String? imageId;
  final CatImageModel? image;

  CatFavouriteModel({
    required this.id,
    required this.imageId,
    required this.image,
  });

  factory CatFavouriteModel.fromJson(Map<String, dynamic> json) {
    return CatFavouriteModel(
      id: json['id'],
      imageId: json['image_id'],
      image:
          json['image'] != null ? CatImageModel.fromJson(json['image']) : null,
    );
  }
}
