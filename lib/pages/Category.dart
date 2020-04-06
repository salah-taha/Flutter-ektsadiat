import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/new.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
//  final CategoryModel categoryModel;
  final String cateID;
  final String cateName;
  Category(this.cateID, this.cateName);
  @override
  _CategoryBody createState() =>
      _CategoryBody(cateID: this.cateID, cateName: cateName);
}

class _CategoryBody extends State<Category> {
//  final CategoryModel category ;
  final String cateID;
  final String cateName;

  _CategoryBody({this.cateID, this.cateName});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List<Widget>();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            cateName ?? ' ',
            style: TextStyle(fontFamily: 'Reem'),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
              future: Api.getCatePosts(cateID: cateID.toString()),
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
                snapshot.data.forEach((_new) {
                  Widget item = ListTile(
                    title: Text(
                      _new['title_ar'] ?? '',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo'),
                    ),
                    subtitle: Text(
                      _new['created_at'] ?? '',
                      style: TextStyle(fontSize: 9, fontFamily: 'Cairo'),
                    ),
                    leading: FadeInImage.assetNetwork(
                      image: 'https://eqtisadiat.com/public/images/' +
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
            ),
          ],
        ));
  }
}

//class _List extends StatelessWidget {
//  final CategoryModel cate = new CategoryModel();
//
//  _List({Key key, @required cate}) : super(key: key);
//
//  final List<Widget> widgets = new List<Widget>();
//
//  bool _allIn() {
//    if (this.cate.news.length >= 1) {
//      this.cate.news.forEach((_new) {
//        Widget item = ListTile(
//          title: Text(
//            _new.titleAr != null ? _new.titleAr : '',
//            style: TextStyle(fontSize: 14),
//          ),
//          subtitle: Text(
//            _new.createdAt != null ? _new.createdAt : '',
//            style: TextStyle(fontSize: 11),
//          ),
//          leading: FadeInImage.assetNetwork(
//            image: 'https://eqtisadiat.com/public/images/' + _new.image,
//            placeholder: 'assets/img/placeholder.png',
//            fit: BoxFit.cover,
//          ),
//          trailing: Icon(Icons.keyboard_arrow_left),
//          onTap: () {},
//        );
//        widgets.add(item);
//      });
//    }
//
//    return true;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SizedBox(
//        height: MediaQuery.of(context).size.height,
//        child: MediaQuery.removePadding(
//            removeTop: true,
//            removeBottom: true,
//            context: context,
//            child: Directionality(
//              textDirection: TextDirection.rtl,
//              child: ListView(
//                children: _allIn() ? widgets : <Widget>[],
//              ),
//            )));
//  }
//}
