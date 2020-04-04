import 'package:eqtisadiat/pages/cates.dart';
import 'package:eqtisadiat/pages/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:eqtisadiat/Models/Video.dart';
import 'package:flutter/material.dart';

import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/today.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoModel extends StatefulWidget{

   Api api;
  VideoModel(this.api);

  @override

   _VideoModel createState() => _VideoModel(this.api);
}

class _VideoModel extends State<VideoModel>{

  Api _videos;

  _VideoModel(this._videos);

  @override

  Widget build (BuildContext context)
  {
    List<Video> videos = new List<Video>();
    videos = this._videos.getVideosWithoutTime();
    List<Widget> widgets = new List<Widget>();

    videos.forEach((video){

        String id = YoutubePlayer.convertUrlToId(video.url);
             YoutubePlayerController _controller= YoutubePlayerController(
                            initialVideoId: id,
                            
                            flags: YoutubePlayerFlags(
                                      mute: false,
                                      isLive: false,
                                      autoPlay: false,
                                      disableDragSeek: false,
                                      controlsVisibleAtStart: false,
                                      enableCaption: false,
                                      hideThumbnail: false,  
                                  ),
                              
                        );

      Widget sample = Directionality(
        textDirection: TextDirection.rtl,
        child:Container(
        width: MediaQuery.of(context).size.width,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator:true,    
                           ),
                            Padding(padding: EdgeInsets.only(top: 5),),
                            Directionality(
                             textDirection: TextDirection.rtl,
                             child: Text(video.title,style: TextStyle(fontFamily: 'Cairo',fontSize: 12),), 
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 5),),
                            Text(video.createdAt,style: TextStyle(fontFamily: 'Cairo',fontSize: 9, color: Colors.grey),),
                            Padding(padding: EdgeInsets.only(bottom: 10),),
          ],
        ),
      ),
      );
      widgets.add(sample);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('شاهد الفيديوهات',style: TextStyle(fontFamily: 'Reem'),),
        centerTitle: true,

      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: widgets,
            ),
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
                padding: EdgeInsets.only(top:10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => TodayModel(this._videos)  ));
                  },
                   child: Column(
                              children: <Widget>[
                                Icon(Icons.today),
                                Center(child: Text('اليوم',style: TextStyle(fontFamily: 'Cairo',fontSize: 11,fontWeight: FontWeight.w600,),)),
                              ],
                            ),
                ),
              )
            ),

            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(top:10),
                child: InkWell(
                  onTap: (){},
                  child: Column(
                  children: <Widget>[
                    Icon(Icons.ondemand_video),
                    Center(child: Text('شاهد',style: TextStyle(fontFamily: 'Cairo',fontSize: 11,fontWeight: FontWeight.w600,),)),
                  ],
                ),
                ),
              )
            ),
            Expanded(
              child: Container(
                height: 60,
                
                child: Column(
                  children: <Widget>[
                   Padding(padding: EdgeInsets.only(top:34)),
                    Center(child: Text('الرئيسية',style: TextStyle(fontFamily: 'Cairo',fontSize: 11,fontWeight: FontWeight.w600,),)),
                  ],
                ),
              )
            ),
            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(top:10),
                child: InkWell(
                  onTap:(){
                    
                    Navigator.push(context,MaterialPageRoute(builder: (context) => NewsModel(this._videos,'أخبار شائعة')  ));
                  },
                  child:Column(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Center(child: Text('الشائع',style: TextStyle(fontFamily: 'Cairo',fontSize: 11,fontWeight: FontWeight.w600,),)),
                  ],
                ),
                ),
              )
            ),
            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(top:10),
                child: InkWell(
                  onTap: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesPage(this._videos)  ));},
                  child: Column(
                  children: <Widget>[
                    Icon(Icons.format_list_bulleted),
                    Center(child: Text('الاقسام',style: TextStyle(fontFamily: 'Cairo',fontSize: 11,fontWeight: FontWeight.w600,))),
                  ],
                ),
                )
              )
            ),
           ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.grey[300],
        elevation: 2.2,

      ),
    
    );
  }
}