import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/Category.dart';
import 'package:eqtisadiat/pages/new.dart';
import 'package:eqtisadiat/pages/news.dart';
import 'package:eqtisadiat/pages/video.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  Api api;
  CategoriesPage(this.api);
  @override
  _CategoriesPage createState() => _CategoriesPage(api: this.api);
}

class _CategoriesPage extends State<CategoriesPage> {
  final Api api;
  _CategoriesPage({this.api});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List<Widget>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'الاقسـام',
          style: TextStyle(fontFamily: 'Reem'),
        ),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        FutureBuilder(
          future: api.getCatesData(),
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

            snapshot.data.forEach((element) {
              List<Widget> _news = new List<Widget>();

              if (element['posts'].length > 6) {
                for (int i = 0; i <= 6; i++) {
                  Widget item = ListTile(
                    title: Text(
                      element['posts'][i] != null
                          ? element['posts'][i]['title_ar']
                          : '',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo'),
                    ),
                    subtitle: Text(
                      element['posts'][i]['created_at'] != null
                          ? element['posts'][i]['created_at']
                          : '',
                      style: TextStyle(fontSize: 9, fontFamily: 'Cairo'),
                    ),
                    leading: element['posts'][i]['image'] != null
                        ? Image.network('http://eqtisadiat.com/public/images/' +
                            element['posts'][i]['image'])
                        : Image.asset('assets/img/placeholder.png'),
                    trailing: Icon(Icons.keyboard_arrow_left),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPage(element['posts'][i])),
                      );
                    },
                  );
                  _news.add(item);
                }
              } else {
                element['posts'].forEach((_new) {
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
                    leading: _new['image'] != null
                        ? Image.network('http://eqtisadiat.com/public/images/' +
                            _new['image'])
                        : Image.asset('assets/img/placeholder.png'),
                    trailing: Icon(Icons.keyboard_arrow_left),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPage(_new)),
                      );
                    },
                  );
                  _news.add(item);
                });
              }

              Widget sample = Directionality(
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10, top: 5),
                                      child: Text(element['name_ar'],
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo',
                                            fontSize: 14,
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.red,
                                    ),
                                    iconSize: 18,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Category(
                                                element['id'].toString(),
                                                element['name_ar'])),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    primary: false,
                                    semanticChildCount: _news.length,
                                    children: _news),
                              ),
                            ))
                      ],
                    )),
              );
              widgets.add(sample);
            });
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
              ),
            );
          },
        ),
      ]),
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
            )),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.grey[300],
        elevation: 2.2,
      ),
    );
  }
}
