import 'package:eqtisadiat/Models/News.dart';

class CategoryModel {
  int id;
  String name;
  String slug;
  String nameAr;
  String slugAr;
  int position;
  int status;
  List<News> news;
  String createdAt;
  String updatedAt;

  CategoryModel(
      {this.id,
      this.name,
      this.slug,
      this.nameAr,
      this.slugAr,
      this.position,
      this.status,
      this.news,
      this.createdAt,
      this.updatedAt});

  // CategoryModel.fromJson(json) {
  //   id = json['id'];
  //   name = json['name'];
  //   slug = json['slug'];
  //   nameAr = json['name_ar'];
  //   slugAr = json['slug_ar'];
  //   position = json['position'];
  //   status = json['status'];
  //   if (json['posts'] != null) {
  //     news = new List<News>();
  //     json['posts'].forEach((v) {
  //       news.add(new News.fromJson(v));
  //     });
  //   }
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['slug'] = this.slug;
  //   data['name_ar'] = this.nameAr;
  //   data['slug_ar'] = this.slugAr;
  //   data['position'] = this.position;
  //   data['status'] = this.status;
  //   if (this.news != null) {
  //     data['posts'] = this.news.map((v) => v.toJson()).toList();
  //   }
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }

}