import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eqtisadiat/Models/Category.dart';
import 'package:eqtisadiat/Models/News.dart';
import 'package:eqtisadiat/Models/Video.dart';
import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/Category.dart';
import 'package:eqtisadiat/pages/cates.dart';
import 'package:eqtisadiat/pages/new.dart';
import 'package:eqtisadiat/pages/news.dart';
import 'package:eqtisadiat/pages/today.dart';
import 'package:eqtisadiat/pages/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Home extends StatefulWidget {
  final Api api;
  Home(this.api);
  @override
  _HomeState createState() => _HomeState(this.api);
}

class _HomeState extends State<Home> {
  final Api api;

  List<News> _sliders = new List<News>();

  List<Video> _videos = new List<Video>();
  List<CategoryModel> _categories = new List<CategoryModel>();
  List<Widget> catesview = new List<Widget>();

  List<Widget> _catesListedIn = new List<Widget>();
  List<Widget> _ui = new List<Widget>();
  Timer timer;

  _HomeState(this.api) {
    //api.getDataFromApi();
  }
//  void _continue() {
//    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
//      if (api.dataIsDone()) {
//        setState(() {
//          this._sliders = api.getSliders();
//
//          this._categories = api.getCategories();
//
//          this._videos = api.getVideos();
//
//          timer.cancel();
//        });
//      }
//    });
//
//    Timer t = Timer.periodic(Duration(minutes: 1), (t) {
//      setState(() {
//        api.updateTimes(this._sliders);
//
//        if (this._categories.length >= 1) {
//          this._categories.forEach((element) {
//            api.updateTimes(element.news);
//          });
//        }
//      });
//    });
//  }
//
//  @override
//  initState() {
//    this._continue();
//    super.initState();
//  }

  Widget build(BuildContext context) {
//    if (this._ui.length < 1) {
//      this._categories.asMap().forEach((i, item) {
//        if (i == 0) {
//          this._ui.add(_Category(categories: this._categories));
//          this._ui.add(_HomeSlider(sliders: this._sliders));
//        }
//
//        if (i == 2) {
//          this._ui.add(_Videos(videos: this._videos));
//        }
//
//        if (i > 2 || i == 1) {
//          if (i % 2 == 0) {
//            this._ui.add(_LatestNews(breaking: item.news, title: item.nameAr));
//          } else {
//            this._ui.add(_LatestNews2(breaking: item.news, title: item.nameAr));
//          }
//        }
//      });
//    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('اقتصاديات',
            style:
                TextStyle(fontSize: 22, fontFamily: 'Reem', color: Colors.red)),
        leading: InkWell(
          child: Icon(Icons.notification_important, color: Colors.red),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsModel(this.api, 'أخبار عاجلة')));
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
//          SingleChildScrollView(
//            child: Column(
//                children: this._sliders.length >= 1
//                    ? this._ui
//                    : <Widget>[
//                        Center(
//                          child: Padding(
//                            padding: EdgeInsets.only(top: 20),
//                            child: Container(
//                              width: 50,
//                              height: 50,
//                              child: Image.asset('assets/img/loading.gif'),
//                            ),
//                          ),
//                        )
//                      ]),
//          )
          FutureBuilder(
            future: api.getDataFromApi2(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              snapshot.data['cates'].asMap().forEach((i, item) {
                if (i == 0) {
                  this._ui.add(_Category(categories: snapshot.data['cates']));
                  this._ui.add(_HomeSlider(sliders: snapshot.data['sliders']));
                }

                if (i == 2) {
                  this._ui.add(_Videos(videos: snapshot.data['videos']));
                }

                if (i > 2 || i == 1) {
                  if (i % 2 == 0) {
                    this._ui.add(_LatestNews(
                        breaking: item['posts'], title: item['name_ar']));
                  } else {
                    this._ui.add(_LatestNews2(
                        breaking: item['posts'], title: item['name_ar']));
                  }
                }
              });
              return SingleChildScrollView(
                child: Column(
                  children: this._ui,
                ),
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
                          builder: (context) => TodayModel(this.api)));
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
                          builder: (context) => VideoModel(this.api)));
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
                              NewsModel(this.api, 'أخبار شائعة')));
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
                                    CategoriesPage(this.api)));
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

class _HomeSlider extends StatelessWidget {
  final sliders;
  _HomeSlider({Key key, @required this.sliders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List<Widget>();

    bool _dataIsHere() {
      this.sliders.forEach((_new) {
        Widget item = InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPage(_new)),
            );
          },
          child: Stack(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop),
                        image: new NetworkImage(
                            'https://eqtisadiat.com/public/images/' +
                                _new['image']),
                      ))),
              Positioned(
                top: 30,
                right: 25,
                child: SizedBox(
                  height: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 15, left: 15, top: 2, bottom: 2),
                      child: Text(
                        _new['category']['name_ar'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Reem',
                            fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 25,
                top: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  _new['title_ar'],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
              )
            ],
          ),
        );

        items.add(item);
      });
      return true;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        height: 200,
        autoPlay: true,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        items: _dataIsHere()
            ? items
            : <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop),
                              image:
                                  new AssetImage('assets/img/placeholder.png'),
                            ))),
                  ],
                ),
              ],
      ),
    );
  }
}

class _LatestNews extends StatelessWidget {
  final breaking;
  final String title;
  _LatestNews({Key key, @required this.breaking, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List<Widget>();

    bool _dataIsHere() {
      if (this.breaking != null) {
        if (this.breaking.length > 0) {
          if (this.breaking.length >= 10) {
            for (var _i = 0; _i <= 10; _i++) {
              Widget item = ListTile(
                title: Text(
                  this.breaking[_i]['title_ar'] != null
                      ? this.breaking[_i]['title_ar']
                      : '',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Cairo'),
                ),
                subtitle: Text(
                  this.breaking[_i]['created_at'] != null
                      ? this.breaking[_i]['created_at']
                      : '',
                  style: TextStyle(fontSize: 9, fontFamily: 'Cairo'),
                ),
                leading: FadeInImage.assetNetwork(
                  image: 'http://eqtisadiat.com/public/images/' +
                      this.breaking[_i]['image'],
                  placeholder: 'assets/img/placeholder.png',
                  fit: BoxFit.cover,
                ),
                trailing: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPage(this.breaking[_i])),
                  );
                },
              );
              items.add(item);
            }
          } else {
            this.breaking.forEach((_new) {
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
                  image: 'http://eqtisadiat.com/public/images/' + _new['image'],
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
              items.add(item);
            });
          }
        } else {
          return false;
        }

        return true;
      } else {
        return false;
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 100,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Text(title,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                          fontSize: 14,
                        )),
                  ),
                ),
              ),
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 100,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: Scrollbar(
                      controller: ScrollController(
                        initialScrollOffset: 1.0,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        semanticChildCount: items.length,
                        children: _dataIsHere()
                            ? items
                            : <Widget>[
                                ListTile(
                                  title: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    '',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/img/placeholder.png'),
                                    fit: BoxFit.cover,
                                    colorBlendMode: BlendMode.darken,
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_left),
                                  onTap: () {},
                                ),
                              ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}

class _Videos extends StatelessWidget {
  final videos;

  _Videos({
    Key key,
    @required this.videos,
  }) : super(key: key);
  final List<Widget> widgets = new List<Widget>();

  bool _dataIn(BuildContext context) {
    if (this.videos != null) {
      if (this.videos.length > 0) {
        this.videos.forEach((element) {
          String id = YoutubePlayer.convertUrlToId(element['url']);
          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: id,
            flags: YoutubePlayerFlags(
              mute: false,
              isLive: false,
              autoPlay: false,
              controlsVisibleAtStart: false,
              enableCaption: false,
              hideThumbnail: false,
              loop: false,
            ),
          );
          Widget widget = Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: (MediaQuery.of(context).size.width / 2),
              height: 150,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
          );

          widgets.add(widget);
        });
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
        padding: EdgeInsets.only(bottom: 0),
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _dataIn(context)
                ? widgets
                : <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/img/video-placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        height: 140,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/img/video-placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final categories;
  _Category({Key key, @required this.categories}) : super(key: key);
  final List<Widget> widgets = new List<Widget>();

  bool _finalIn(BuildContext context) {
    if (categories != null) {
      if (categories.length >= 1) {
        categories.forEach((element) {
          Widget wid = Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Container(
              child: ButtonBar(
                buttonHeight: 15,
                buttonMinWidth: 100,
                buttonPadding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                element['id'].toString(), element['name_ar'])),
                      );
                    },
                    child: Text(
                      element['name_ar'],
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
              color: Colors.grey[200],
            ),
          );

          widgets.add(wid);
        });

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 35,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: 5, top: 5),
            children: _finalIn(context) ? widgets : <Widget>[],
          ),
        ),
      ),
    );
  }
}

class _LatestNews2 extends StatelessWidget {
  final breaking;
  final String title;
  _LatestNews2({Key key, @required this.breaking, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List<Widget>();

    bool _dataIsHere() {
      if (this.breaking != null) {
        if (this.breaking.length > 0) {
          this.breaking.forEach((_new) {
            Widget item = Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPage(_new)),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.dstATop),
                                  image: new NetworkImage(
                                      'https://eqtisadiat.com/public/images/' +
                                          _new['image']),
                                ))),
                        Positioned(
                          top: 15,
                          right: 12,
                          child: SizedBox(
                            height: 20,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 15, left: 15, top: 2, bottom: 2),
                                child: Text(
                                  this.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Reem',
                                      fontSize: 6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 35,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            _new['title_ar'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                        )
                      ],
                    ),
                  )),
            );

            items.add(item);
          });
        } else {
          return false;
        }

        return true;
      } else {
        return false;
      }
    }

    return Row(
      children: _dataIsHere()
          ? items
          : <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              )
            ],
    );
  }
}
