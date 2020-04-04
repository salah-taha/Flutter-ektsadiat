class Video {
  int id;
  String title;
  String titleAr;
  String slug;
  String slugAr;
  String url;
  String link;
  String linkAr;
  int status;
  String createdAt;
  String updatedAt;
  String createAt;

  Video(
      {this.id,
      this.title,
      this.titleAr,
      this.slug,
      this.slugAr,
      this.url,
      this.link,
      this.linkAr,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createAt});

  Video.fromJson(json) {
    id = json['id'];
    title = json['title'];
    titleAr = json['title_ar'];
    slug = json['slug'];
    slugAr = json['slug_ar'];
    url = json['url'];
    link = json['link'];
    linkAr = json['link_ar'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['slug'] = this.slug;
    data['slug_ar'] = this.slugAr;
    data['url'] = this.url;
    data['link'] = this.link;
    data['link_ar'] = this.linkAr;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}