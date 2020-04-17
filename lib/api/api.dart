// el mafrood na2lna el kalam mn el createdAt l createAt 3al4an nezbot mwdo3 el date da w n5leh sh8al
import 'dart:convert';
import 'dart:io';

import 'package:eqtisadiat/Models/Category.dart';
import 'package:eqtisadiat/Models/News.dart';
import 'package:eqtisadiat/Models/Video.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class Api {
  String news = 'http://eqtisadiat.com/api/v4/sliders';
  String breaking = 'http://eqtisadiat.com/api/v4/breaking';
  String viewed = 'http://eqtisadiat.com/api/v4/viewed';
  String videos = 'http://eqtisadiat.com/api/v4/videos';
  String cates = 'http://eqtisadiat.com/api/v4/categories';
  String today = 'http://eqtisadiat.com/api/today';

  Map data = Map();

  var _sliders = new List<News>();
  var _breaking = new List<News>();
  List<News> _viewed = new List<News>();
  var _videos = new List<Video>();
  var _categories = new List<CategoryModel>();
  List<News> _today = new List<News>();
  SharedPreferences prefs;
  List jsoncates;

  connectionIsReady() async {
    try {
      final result = await InternetAddress.lookup('eqtisadiat.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
  }

  getCatesData() async {
    http.Response response =
        await http.get('http://eqtisadiat.com/api/v4/categories', headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  static getPostWithID({String id}) async {
    http.Response response =
        await http.get('http://eqtisadiat.com/api/v4/post/' + id, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  static getCatePosts({String cateID}) async {
    http.Response response = await http
        .get('http://eqtisadiat.com/api/v3/post/cate/' + cateID, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  getDataFromApi2() async {
    http.Response response = await http.get(this.news, headers: {
      "Accept": "application/json",
    });

    http.Response videoRequest = await http.get(this.videos, headers: {
      "Accept": "application/json",
    });
    http.Response cateRequest = await http.get(this.cates, headers: {
      "Accept": "application/json",
    });

    Map data = Map();
    data['sliders'] = json.decode(response.body);
    data['videos'] = json.decode(videoRequest.body);
    data['cates'] = json.decode(cateRequest.body);

    this.data = data;
    return data;
  }

  getBreakingData() async {
    http.Response response = await http.get(this.breaking, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  getSpreadData() async {
    http.Response response = await http.get(this.viewed, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  getVideosData() async {
    http.Response response = await http.get(this.videos, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  getTodayData() async {
    http.Response response = await http.get(this.today, headers: {
      "Accept": "application/json",
    });

    return json.decode(response.body);
  }

  getDataFromApi() async {
    http.Response response = await http.get(this.news, headers: {
      "Accept": "application/json",
    });

    http.Response videoRequest = await http.get(this.videos, headers: {
      "Accept": "application/json",
    });
    http.Response cateRequest = await http.get(this.cates, headers: {
      "Accept": "application/json",
    });

    this._sliders = json.decode(response.body);

    this._videos = json.decode(videoRequest.body);

    this._categories = json.decode(cateRequest.body);
  }

  getCates() async {
    http.Response cates = await http.get(this.cates, headers: {
      "Accept": "application/json",
    });
    var cates2 = json.decode(cates.body);
    return cates2;
  }

  getTodayFromApi() async {
    http.Response todayRequest = await http.get(this.today, headers: {
      "Accept": "application/json",
    });

    List jsontoday = jsonDecode(todayRequest.body);

    jsontoday.forEach((element) {
      News _new = News(
        accName: element['acc_name'],
        breaking: element['breaking'],
        categoryId: element['category_id'],
        createdAt: element['created_at'],
        details: element['details'],
        detailsAr: element['details_ar'],
        featured: element['featured'],
        hitCount: element['hit_count'],
        id: element['id'],
        image: element['image'],
        reviewedBy: element['reviewed_by'],
        schedule: element['schedule'],
        slider: element['slider'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        smTitle: element['sm_title'],
        source: element['source'],
        sourceAr: element['source_ar'],
        status: element['status'],
        title: element['title'],
        titleAr: element['title_ar'],
        updatedAt: element['updated_at'],
        userName: element['user_name'],
        vedioUrl: element['video_url'],
        category: CategoryModel(
          id: element['category']['id'],
          name: element['category']['name'],
          nameAr: element['category']['name_ar'],
          createdAt: element['category']['created_at'],
          position: element['category']['position'],
          slug: element['category']['slug'],
          slugAr: element['category']['slug_ar'],
          status: element['category']['status'],
          updatedAt: element['category']['updated_at'],
        ),
      );
      this._today.add(_new);
    });
  }

  geTBreakingFromApi() async {
    http.Response breakingRequest = await http.get(this.breaking, headers: {
      "Accept": "application/json",
    });

    json.decode(breakingRequest.body).forEach((element) {
      News _new = News(
        accName: element['acc_name'],
        breaking: element['breaking'],
        categoryId: element['category_id'],
        createdAt: element['created_at'],
        details: element['details'],
        detailsAr: element['details_ar'],
        featured: element['featured'],
        hitCount: element['hit_count'],
        id: element['id'],
        image: element['image'],
        reviewedBy: element['reviewed_by'],
        schedule: element['schedule'],
        slider: element['slider'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        smTitle: element['sm_title'],
        source: element['source'],
        sourceAr: element['source_ar'],
        status: element['status'],
        title: element['title'],
        titleAr: element['title_ar'],
        updatedAt: element['updated_at'],
        userName: element['user_name'],
        vedioUrl: element['video_url'],
        category: CategoryModel(
          id: element['category']['id'],
          name: element['category']['name'],
          nameAr: element['category']['name_ar'],
          createdAt: element['category']['created_at'],
          position: element['category']['position'],
          slug: element['category']['slug'],
          slugAr: element['category']['slug_ar'],
          status: element['category']['status'],
          updatedAt: element['category']['updated_at'],
        ),
      );
      this._breaking.add(_new);
    });
  }

  bool breakingIshere() {
    if (this._breaking.length >= 1) {
      return true;
    } else {
      return false;
    }
  }

  geTViewedFromApi() async {
    http.Response breakingRequest = await http.get(this.viewed, headers: {
      "Accept": "application/json",
    });

    json.decode(breakingRequest.body).forEach((element) {
      News _new = News(
        accName: element['acc_name'],
        breaking: element['breaking'],
        categoryId: element['category_id'],
        createdAt: element['created_at'],
        details: element['details'],
        detailsAr: element['details_ar'],
        featured: element['featured'],
        hitCount: element['hit_count'],
        id: element['id'],
        image: element['image'],
        reviewedBy: element['reviewed_by'],
        schedule: element['schedule'],
        slider: element['slider'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        smTitle: element['sm_title'],
        source: element['source'],
        sourceAr: element['source_ar'],
        status: element['status'],
        title: element['title'],
        titleAr: element['title_ar'],
        updatedAt: element['updated_at'],
        userName: element['user_name'],
        vedioUrl: element['video_url'],
        category: CategoryModel(
          id: element['category']['id'],
          name: element['category']['name'],
          nameAr: element['category']['name_ar'],
          createdAt: element['category']['created_at'],
          position: element['category']['position'],
          slug: element['category']['slug'],
          slugAr: element['category']['slug_ar'],
          status: element['category']['status'],
          updatedAt: element['category']['updated_at'],
        ),
      );
      this._viewed.add(_new);
    });
  }

  bool viewedIshere() {
    if (this._viewed.length >= 1) {
      return true;
    } else {
      return false;
    }
  }

  bool todayIsherr() {
    if (this._today.length >= 1) {
      return true;
    } else {
      return false;
    }
  }

  void updateNews() {
    this.updateTimes(this._today);
  }

  void updateTimes(List<News> out) {
    timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
    var date = new DateTime.now();
    out.forEach((element) {
      var old = DateTime.parse(element.createdAt);

      final difference = date.difference(old);

      element.createAt = timeago
          .format(date.subtract(difference), locale: 'ar', allowFromNow: true)
          .toString();
    });
  }

  void updateTimesForNew(News out) {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    var date = new DateTime.now();

    var old = DateTime.parse(out.createdAt);

    final difference = date.difference(old);

    out.createAt =
        timeago.format(date.subtract(difference), locale: 'ar').toString();
  }

  void getNewsForCategory() async {
    this._categories.forEach((element) async {
      http.Response response = await http.get(
          'http://eqtisadiat.com/api/v3/post/cate/' + element.id.toString(),
          headers: {
            "Accept": "application/json",
          });

      List<News> _catePosts = new List<News>();
      json.decode(response.body).forEach((element) {
        News _new = News(
          accName: element['acc_name'],
          breaking: element['breaking'],
          categoryId: element['category_id'],
          createdAt: element['created_at'],
          details: element['details'],
          detailsAr: element['details_ar'],
          featured: element['featured'],
          hitCount: element['hit_count'],
          id: element['id'],
          image: element['image'],
          reviewedBy: element['reviewed_by'],
          schedule: element['schedule'],
          slider: element['slider'],
          slug: element['slug'],
          slugAr: element['slug_ar'],
          smTitle: element['sm_title'],
          source: element['source'],
          sourceAr: element['source_ar'],
          status: element['status'],
          title: element['title'],
          titleAr: element['title_ar'],
          updatedAt: element['updated_at'],
          userName: element['user_name'],
          vedioUrl: element['video_url'],
          category: CategoryModel(
            id: element['category']['id'],
            name: element['category']['name'],
            nameAr: element['category']['name_ar'],
            createdAt: element['category']['created_at'],
            position: element['category']['position'],
            slug: element['category']['slug'],
            slugAr: element['category']['slug_ar'],
            status: element['category']['status'],
            updatedAt: element['category']['updated_at'],
          ),
        );
        _catePosts.add(_new);
      });
      this.updateTimes(_catePosts);
      this._categories.forEach((category) {
        if (category.id == element.id) {
          category.news = _catePosts;
        }
      });
    });
  }

  getMoreNewsForCategory(int id, int post) async {
    http.Response response = await http.get(
        'http://eqtisadiat.com/v3/post/cate/' +
            id.toString() +
            '/next/' +
            post.toString(),
        headers: {
          "Accept": "application/json",
        });

    List<News> _catePosts = new List<News>();
    json.decode(response.body).forEach((element) {
      News _new = News(
        accName: element['acc_name'],
        breaking: element['breaking'],
        categoryId: element['category_id'],
        createdAt: element['created_at'],
        details: element['details'],
        detailsAr: element['details_ar'],
        featured: element['featured'],
        hitCount: element['hit_count'],
        id: element['id'],
        image: element['image'],
        reviewedBy: element['reviewed_by'],
        schedule: element['schedule'],
        slider: element['slider'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        smTitle: element['sm_title'],
        source: element['source'],
        sourceAr: element['source_ar'],
        status: element['status'],
        title: element['title'],
        titleAr: element['title_ar'],
        updatedAt: element['updated_at'],
        userName: element['user_name'],
        vedioUrl: element['video_url'],
        category: CategoryModel(
          id: element['category']['id'],
          name: element['category']['name'],
          nameAr: element['category']['name_ar'],
          createdAt: element['category']['created_at'],
          position: element['category']['position'],
          slug: element['category']['slug'],
          slugAr: element['category']['slug_ar'],
          status: element['category']['status'],
          updatedAt: element['category']['updated_at'],
        ),
      );
      _catePosts.add(_new);
    });
    this.updateTimes(_catePosts);
    this._categories.forEach((category) {
      if (category.id == id) {
        category.news.addAll(_catePosts);
      }
    });
  }

  dataIsDone() {
    if (this._sliders.length >= 1) {
      return true;
    } else {
      return false;
    }
  }

  getSliders() {
    return this._sliders;
  }

  getbreaking() {
    return this._breaking;
  }

  getViewed() {
    return this._viewed;
  }

  getVideos() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    var date = new DateTime.now();
    this._videos.forEach((element) {
      var old = DateTime.parse(element.createdAt);

      final difference = date.difference(old);

      element.createAt =
          timeago.format(date.subtract(difference), locale: 'ar').toString();
    });

    return this._videos;
  }

  getCategories() {
    return this._categories;
  }

  getToday() {
    return this._today;
  }

  getTodayWithoutTime() {
    return this._today;
  }

  getCategorieswithoutTime() {
    return this._categories;
  }

  getVideosWithoutTime() {
    return this._videos;
  }
}
