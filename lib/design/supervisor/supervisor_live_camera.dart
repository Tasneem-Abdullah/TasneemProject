import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/supervisor.dart';

class live_camera extends StatefulWidget {
  String status,doc_id;
  live_camera(this.status,this.doc_id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return live_camerastate();
  }
}

class live_camerastate extends State<live_camera> {
  
String status_data;
  Uint8List image;
  // String _camera_url="http://192.168.1.5:8080/video";
  String _camera_url;
 
  Supervisor sup=new Supervisor();

  VlcPlayerController _videoViewController;

  @override
  void initState() {
    super.initState();
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      setState(() {});
    });

 status_data=widget.status;

 sup.Open_live_streaming().then((data){
   setState(() {
     _camera_url=data;
     _videoViewController.setStreamUrl(_camera_url);
   });
 });
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Hexcolor('#2c3e50'),
        leading: Icon(Icons.star, color: Colors.black),
        title: const Text(
          'Live video',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
       
        actions: <Widget>[
           (widget.status=='Accept mission' || widget.status=='Accepted') ?
                FlatButton(
                    onPressed: () {
                      if(status_data=='Accept mission'){
                      setState(() {
                        status_data="Accepted";
                        });
                        sup.Update_status(status_data,widget.doc_id);
                      
                      }
                    },
                    color: Hexcolor('#2c3e50'),
                    child: Row(
                      children: <Widget>[
                        Text(status_data,style:TextStyle(color: status_data=='Accept mission'? Colors.red : Colors.lightBlue) ,)
                      ],
                    )
                )
                :Container()
              ],
      ),
       body:Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                new Container(
                  child: RotatedBox(
              quarterTurns: 5,
                    child: new VlcPlayer(
                      aspectRatio: 16 / 9,
                      url: _camera_url,
                      controller: _videoViewController,
                      placeholder: Container(
                        height: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()],
                        ),
                      ),
                    ),
                  ),
                ),
                new Container(
                    child: Row(
                  children: <Widget>[
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(150, 250, 0, 0),
                     
                    )
                  ],
                ),
                    

                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}