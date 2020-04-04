import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eqtisadiat/pages/splash.dart';


class ErrorEstablish extends StatefulWidget{
  @override
  _ErrorEstablishState createState() => _ErrorEstablishState();
  }
 
class _ErrorEstablishState extends State<ErrorEstablish>{
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color:Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top:210),
          child: Column(
            children: <Widget>[
              Text('404',
              style: TextStyle(fontSize: 40,color: Colors.red,fontFamily: 'Cairo'),
              ),
              Text('لا يوجد إتصال بالانترنت',
              style: TextStyle(fontSize: 24,fontFamily: 'Cairo'),),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
              OutlineButton.icon(
                icon: Icon(Icons.replay),
                label: Text('مرة أخري',style: TextStyle(fontFamily: 'Cairo'),),
                color: Colors.red,
                textColor: Colors.red,
                highlightedBorderColor: Colors.red,
              onPressed: (){
                 Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SplashScreen() ));
              },
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
  
}
