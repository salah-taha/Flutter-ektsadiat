import 'package:flutter/material.dart';
import 'package:eqtisadiat/Models/Category.dart';
import 'package:eqtisadiat/pages/new.dart';




class Category extends StatefulWidget{
  final CategoryModel categoryModel;
  Category(this.categoryModel);
  @override
  _CategoryBody createState ()=> _CategoryBody(category: this.categoryModel);
}

class _CategoryBody extends State<Category>{
  final CategoryModel category ;
 _CategoryBody({this.category});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List<Widget>();
        bool _allIn(){
          
            if(this.category.news.length >=1)
            {
              this.category.news.forEach((_new){
                    Widget item =  ListTile(
                            title: Text(_new.titleAr != null ? _new.titleAr.toString() : '',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w800,fontFamily: 'Cairo'),),
                              subtitle: Text(_new.createAt != null ? _new.createAt.toString() : '' ,style: TextStyle(fontSize: 9,fontFamily: 'Cairo'),),
                            leading: FadeInImage.assetNetwork(
                              image: 'https://eqtisadiat.com/public/images/'+_new.image.toString(),
                              placeholder: 'assets/img/placeholder.png',
                              fit: BoxFit.cover,
                              ),
                                trailing: Icon(Icons.keyboard_arrow_left),
                                onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NewPage(_new)),
                                  );
                                },
                          );
                          widgets.add(item);
                    
                        
        });

            }
            else
            {
              
            }
          
        
        return true;
      }
      
        
        return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(category.nameAr,style: TextStyle(fontFamily: 'Reem'),),
        centerTitle: true,
      ),
      body: Stack(
        
        children: <Widget>[
          SingleChildScrollView(
                child:SizedBox(
                height: MediaQuery.of(context).size.height,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,

                  child: Directionality(
                     textDirection: TextDirection.rtl,
                     child: ListView(
                  
                    children: _allIn() ?  widgets : <Widget>[
                    
                  ],
                ),
                  )
                )
              ),
          )
        ],
      )
    );
  }

}

class _List extends StatelessWidget{

  final CategoryModel cate = new CategoryModel();

  _List({Key key, @required cate}): super(key: key);
  
  final List<Widget> widgets = new List<Widget>();

  bool _allIn(){
   
      if(this.cate.news.length >=1)
      {
         this.cate.news.forEach((_new){
                Widget item =  ListTile(
                        title: Text(_new.titleAr != null ? _new.titleAr : '',style: TextStyle(fontSize: 14),),
                          subtitle: Text(_new.createdAt != null ? _new.createdAt : '' ,style: TextStyle(fontSize: 11),),
                          leading: FadeInImage.assetNetwork(
                           image: 'https://eqtisadiat.com/public/images/'+_new.image,
                           placeholder: 'assets/img/placeholder.png',
                           fit: BoxFit.cover,
                          ),
                            trailing: Icon(Icons.keyboard_arrow_left),
                            onTap: (){
                             
                            },
                      );
                      widgets.add(item);
                 
                     
    });
    
      }
    
   return true;
  }
  
  
  
  @override

  

  
    
  Widget build(BuildContext context)
  {
    return  SizedBox(
                height: MediaQuery.of(context).size.height,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: Directionality(
                     textDirection: TextDirection.rtl,
                     child: ListView(
                  
                  children: _allIn() ?  widgets : <Widget>[
                    
                  ],
                ),
                  )
                )
              );
             
  }
}