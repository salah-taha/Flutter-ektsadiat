import 'package:eqtisadiat/Models/News.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPage extends StatefulWidget {
  News _new = new News();
  NewPage(this._new);
  @override
  _NewPage createState() => _NewPage(post: _new);
}

class _NewPage extends State<NewPage> {
  final News post;

  _NewPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    Widget wed;
    List<Widget> tagWidgets = new List<Widget>();
    bool _done(BuildContext context) {
      if (post != null) {
        List tags = post.source.split(',');
        List date = post.createdAt.split(' ');
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
                        post.category.nameAr,
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
                    post.titleAr,
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
                          post.createAt,
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
                              Colors.black.withOpacity(0.6), BlendMode.dstATop),
                          image: new NetworkImage(
                              'https://eqtisadiat.com/public/images/' +
                                  post.image),
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
                          post.userName,
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
                      data: post.detailsAr,
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

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.titleAr),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Share.share('https://eqtisadiat.com/v/' +
                post.categoryId.toString() +
                '/' +
                post.category.slug.toString() +
                '/article/' +
                post.id.toString() +
                '/' +
                post.slug);
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
      body: _done(context)
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: wed,
              ),
            )
          : Container(),
    );
  }
}
