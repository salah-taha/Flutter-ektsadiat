// el mafrood na2lna el kalam mn el createdAt l createAt 3al4an nezbot mwdo3 el date da w n5leh sh8al
import 'dart:convert';
import 'dart:io';

import 'package:eqtisadiat/Models/Category.dart';
import 'package:eqtisadiat/Models/News.dart';
import 'package:eqtisadiat/Models/Video.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

const imageUrlPrefix = 'http://eqtisadiat.com/public/images/{imageName}';

const getPostWithIdEndPoint = 'http://eqtisadiat.com/api/v4/post/{id}';

class Api {
  String news = 'https://eqtisadiat.com/api/v4/sliders';
  String breaking = 'https://eqtisadiat.com/api/v4/breaking';
  String viewed = 'https://eqtisadiat.com/api/v4/viewed';
  String videos = 'https://eqtisadiat.com/api/v4/videos';
  String cates = 'https://eqtisadiat.com/api/v4/categories';
  String today = 'https://eqtisadiat.com/api/today';

  List<News> _sliders = new List<News>();
  List<News> _breaking = new List<News>();
  List<News> _viewed = new List<News>();
  List<Video> _videos = new List<Video>();
  List<CategoryModel> _categories = new List<CategoryModel>();
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

    print('gotData');

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
      _sliders.add(_new);
    });

    json.decode(videoRequest.body).forEach((element) {
      Video _new = Video(
        id: element['id'],
        link: element['link'],
        linkAr: element['link_ar'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        status: element['status'],
        title: element['title'],
        createdAt: element['created_at'],
        titleAr: element['title_ar'],
        updatedAt: element['updated_at'],
        url: element['url'],
      );
      this._videos.add(_new);
    });

    json.decode(cateRequest.body).forEach((element) {
      List<News> _cates_news = new List<News>();
      element['posts'].forEach((post) {
        News _one = News(
          accName: post['acc_name'],
          breaking: post['breaking'],
          categoryId: post['category_id'],
          createdAt: post['created_at'],
          details: post['details'],
          detailsAr: post['details_ar'],
          featured: post['featured'],
          hitCount: post['hit_count'],
          id: post['id'],
          image: post['image'],
          reviewedBy: post['reviewed_by'],
          schedule: post['schedule'],
          slider: post['slider'],
          slug: post['slug'],
          slugAr: post['slug_ar'],
          smTitle: post['sm_title'],
          source: post['source'],
          sourceAr: post['source_ar'],
          status: post['status'],
          title: post['title'],
          titleAr: post['title_ar'],
          updatedAt: post['updated_at'],
          userName: post['user_name'],
          vedioUrl: post['video_url'],
          category: CategoryModel(
            id: element['id'],
            name: element['name'],
            nameAr: element['name_ar'],
            createdAt: element['created_at'],
            position: element['position'],
            slug: element['slug'],
            slugAr: element['slug_ar'],
            status: element['status'],
            updatedAt: element['updated_at'],
            news: new List<News>(),
          ),
        );

        _cates_news.add(_one);
      });
      CategoryModel cate = CategoryModel(
        id: element['id'],
        name: element['name'],
        nameAr: element['name_ar'],
        createdAt: element['created_at'],
        position: element['position'],
        slug: element['slug'],
        slugAr: element['slug_ar'],
        status: element['status'],
        updatedAt: element['updated_at'],
        news: _cates_news,
      );

      this._categories.add(cate);
    });
    print('Data Converted');
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
          'https://eqtisadiat.com/api/v3/post/cate/' + element.id.toString(),
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
        'https://eqtisadiat.com/v3/post/cate/' +
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
