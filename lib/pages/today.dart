import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/cates.dart';
import 'package:eqtisadiat/pages/new.dart';
import 'package:eqtisadiat/pages/news.dart';
import 'package:eqtisadiat/pages/video.dart';
import 'package:flutter/material.dart';

class TodayModel extends StatefulWidget {
  Api api;
  TodayModel(this.api);
  @override
  _Today createState() => _Today(news: this.api);
}

class _Today extends State<TodayModel> {
  final Api news;
  List _today = new List();
  _Today({this.news});

//  @override
//  void initState() {
//    if(!news.todayIsherr()){
//      news.getTodayFromApi();
//    }
//
//    super.initState();
//  }
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List<Widget>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'أخبار اليوم',
          style: TextStyle(fontFamily: 'Reem'),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: news.getTodayData(),
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
                          child: ListView(
                            children: widgets,
                          ),
                        ))),
              );
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
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
                onTap: () {},
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewsModel(this.news, 'أخبار شائعة')));
                },
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
