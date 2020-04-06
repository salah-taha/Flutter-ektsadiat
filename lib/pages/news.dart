import 'package:eqtisadiat/Models/News.dart';
import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/cates.dart';
import 'package:eqtisadiat/pages/new.dart';
import 'package:eqtisadiat/pages/today.dart';
import 'package:eqtisadiat/pages/video.dart';
import 'package:flutter/material.dart';

class NewsModel extends StatefulWidget {
  Api api;
  String title;
  NewsModel(this.api, this.title);
  @override
  _NewsState createState() => _NewsState(news: this.api, title: this.title);
}

class _NewsState extends State<NewsModel> {
  final Api news;
  final String title;
  List<News> _newsList = new List<News>();
  _NewsState({this.news, this.title});

  @override
  void initState() {
    if (this.title == 'أخبار شائعة') {
      if (!this.news.viewedIshere()) {
        this.news.geTViewedFromApi();
      }
    } else {
      if (!this.news.breakingIshere()) {
        this.news.geTBreakingFromApi();
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          this.title,
          style: TextStyle(fontFamily: 'Reem'),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: this.title == 'أخبار شائعة'
                ? widget.api.getSpreadData()
                : widget.api.getBreakingData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/img/loading.gif'),
                    ),
                  ),
                );
              }

              List<Widget> widgets = new List<Widget>();

              if (snapshot.data.length >= 1) {
                snapshot.data.forEach((_new) {
                  Widget item = ListTile(
                    title: Text(
                      _new['title_ar'] != null ? _new['title_ar'] : '',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo'),
                    ),
                    subtitle: Text(
                      _new['created_at'] != null ? _new['created_at'] : '',
                      style: TextStyle(fontSize: 9, fontFamily: 'Cairo'),
                    ),
                    leading: FadeInImage.assetNetwork(
                      image: 'http://eqtisadiat.com/public/images/' +
                          _new['image'],
                      placeholder: 'assets/img/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_left),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPage(_new)),
                      );
                    },
                  );
                  widgets.add(item);
                });
              }

              return SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: MediaQuery.removePadding(
                        removeTop: true,
                        removeBottom: true,
                        context: context,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(children: widgets),
                        ))),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Home',
        child: Icon(Icons.home),
        elevation: 2.0,
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Container(
              height: 60,
              padding: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodayModel(this.news)));
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.today),
                    Center(
                        child: Text(
                      'اليوم',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),
              ),
            )),
            Expanded(
                child: Container(
              height: 60,
              padding: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoModel(this.news)));
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.ondemand_video),
                    Center(
                        child: Text(
                      'شاهد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),
              ),
            )),
            Expanded(
                child: Container(
              height: 60,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 34)),
                  Center(
                      child: Text(
                    'الرئيسية',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ],
              ),
            )),
            Expanded(
                child: Container(
              height: 60,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Center(
                      child: Text(
                    'الشائع',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ],
              ),
            )),
            Expanded(
                child: Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesPage(this.news)));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.format_list_bulleted),
                          Center(
                              child: Text('الاقسام',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ],
                      ),
                    ))),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.grey[300],
        elevation: 2.2,
      ),
    );
  }
}
