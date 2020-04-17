import 'package:eqtisadiat/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPage extends StatefulWidget {
  final _new;
  NewPage(this._new);
  @override
  _NewPage createState() => _NewPage(post: _new);
}

class _NewPage extends State<NewPage> {
  final post;
  var newPost;

  _NewPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    Widget wed;
    List<Widget> tagWidgets = new List<Widget>();

    return Scaffold(
        appBar: AppBar(
          title: Text(post['title_ar']),
          centerTitle: true,
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
            onPressed: () {
              Share.share('http://eqtisadiat.com/v/' +
                  post['id'] +
                  '/' +
                  post['category']['slug'].toString() +
                  '/article/' +
                  post['id'].toString() +
                  '/' +
                  post['slug']);
            },
            backgroundColor: Colors.red,
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
            tooltip: 'مشاركة',
            isExtended: true,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: FutureBuilder(
          future: Api.getPostWithID(id: post['id'].toString()),
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

            if (snapshot.data != null) {
              List tags = snapshot.data['source'] != null
                  ? snapshot.data['source'].split(',')
                  : List();
              List date = snapshot.data['created_at'].split(' ');
              if (tags.length >= 1) {
                tags.forEach((element) {
                  Widget _tag = Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 5),
                    child: OutlineButton(
                      child: Text(
                        element,
                        style: TextStyle(fontSize: 9),
                      ),
                      color: Colors.grey[100],
                      borderSide: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      hoverColor: Colors.grey[100],
                      onPressed: () {},
                    ),
                  );
                  tagWidgets.add(_tag);
                });
              }

              wed = Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 2, bottom: 2),
                            child: Text(
                              snapshot.data['category']['name_ar'] ??
                                  'Category',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          snapshot.data['title_ar'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: SizedBox(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: tagWidgets,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 25,
                            child: OutlineButton.icon(
                              borderSide: BorderSide(color: Colors.transparent),
                              icon: Icon(
                                Icons.alarm,
                                size: 14,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text(
                                snapshot.data['created_at'],
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image: new NetworkImage(
                                    'http://eqtisadiat.com/public/images/' +
                                        snapshot.data['image']),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 25,
                            child: OutlineButton.icon(
                              borderSide: BorderSide(color: Colors.transparent),
                              icon: Icon(
                                Icons.supervised_user_circle,
                                size: 25,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text(
                                snapshot.data['user_name'],
                                style: TextStyle(fontSize: 12),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 45),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Html(
                            data: snapshot.data['details_ar']
                                .toString()
                                .replaceAll('\n', ''),
                            showImages: true,
                            renderNewlines: true,
                            shrinkToFit: true,
                            useRichText: true,
                            linkStyle: const TextStyle(
                              color: Colors.redAccent,
                              decorationColor: Colors.redAccent,
                              decoration: TextDecoration.underline,
                            ),
                            onLinkTap: (url) async {
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Coud not open $url';
                              }
                            },
                            customTextAlign: (dom.Node node) {
                              if (node is dom.Element) {
                                return TextAlign.right;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: wed,
              ),
            );
          },
        ));
  }
}
