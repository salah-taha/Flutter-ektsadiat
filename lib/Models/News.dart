import 'package:eqtisadiat/Models/Category.dart';
class News {
  int id;
  String accName;
  int schedule;
  String title;
  String smTitle;
  String titleAr;
  String slug;
  String slugAr;
  int categoryId;
  String image;
  String vedioUrl;
  String details;
  String detailsAr;
  String source;
  String sourceAr;
  int breaking;
  int featured;
  int slider;
  int status;
  int hitCount;
  String userName;
  CategoryModel category;
  String reviewedBy;
  String createdAt;
  String updatedAt;
  String createAt;

  News(
      {this.id,
      this.accName,
      this.schedule,
      this.title,
      this.smTitle,
      this.titleAr,
      this.slug,
      this.slugAr,
      this.categoryId,
      this.image,
      this.vedioUrl,
      this.details,
      this.detailsAr,
      this.source,
      this.sourceAr,
      this.breaking,
      this.featured,
      this.slider,
      this.status,
      this.hitCount,
      this.userName,
      this.reviewedBy,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.createAt
      });

  // News.fromJson(json) {
  //   id = json['id'];
  //   accName = json['acc_name'];
  //   schedule = json['schedule'];
  //   title = json['title'];
  //   smTitle = json['sm_title'];
  //   titleAr = json['title_ar'];
  //   slug = json['slug'];
  //   slugAr = json['slug_ar'];
  //   categoryId = json['category_id'];
  //   image = json['image'];
  //   vedioUrl = json['vedio_url'];
  //   details = json['details'];
  //   detailsAr = json['details_ar'];
  //   source = json['source'];
  //   sourceAr = json['source_ar'];
  //   breaking = json['breaking'];
  //   featured = json['featured'];
  //   slider = json['slider'];
  //   status = json['status'];
  //   hitCount = json['hit_count'];
  //   userName = json['user_name'];
  //   reviewedBy = json['reviewed_by'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   category = json['category'] != null
  //       ? new CategoryModel.fromJson(json['category'])
  //       : null;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['acc_name'] = this.accName;
  //   data['schedule'] = this.schedule;
  //   data['title'] = this.title;
  //   data['sm_title'] = this.smTitle;
  //   data['title_ar'] = this.titleAr;
  //   data['slug'] = this.slug;
  //   data['slug_ar'] = this.slugAr;
  //   data['category_id'] = this.categoryId;
  //   data['image'] = this.image;
  //   data['vedio_url'] = this.vedioUrl;
  //   data['details'] = this.details;
  //   data['details_ar'] = this.detailsAr;
  //   data['source'] = this.source;
  //   data['source_ar'] = this.sourceAr;
  //   data['breaking'] = this.breaking;
  //   data['featured'] = this.featured;
  //   data['slider'] = this.slider;
  //   data['status'] = this.status;
  //   data['hit_count'] = this.hitCount;
  //   data['user_name'] = this.userName;
  //   data['reviewed_by'] = this.reviewedBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   if (this.category != null) {
  //     data['category'] = this.category.toJson();
  //   }
  //   return data;
  // }

}