import 'package:eqtisadiat/Models/News.dart';
import 'package:eqtisadiat/Models/Video.dart';
import 'package:eqtisadiat/Models/Category.dart';
class TodayHolder{
  List<News> today = new List<News>();
  List<Video> videos = new List<Video>();
  List<CategoryModel> cates = new List<CategoryModel>();

  saveData(List<News> outside, List<Video> outvideos, List<CategoryModel> outcates )
  {
    this.today = outside;
    this.videos = outvideos;
    this.cates = cates;
  }

  returnTodays()
  {
    return this.today;
  }

  returnVideos(){
    return this.videos;
  }

  returnCategories()
  {
    return this.cates;
  }
}