import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';

class live_camera extends StatefulWidget {
  live_camera();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return live_camerastate();
  }
}

class live_camerastate extends State<live_camera> {
  
  Uint8List image;
  String _camera_url="http://192.168.1.5:8080/video";
 



 

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
                      padding: EdgeInsets.fromLTRB(5, 250, 0, 0),
                      child: FlatButton(
                          onPressed: () {
                            if(_camera_url=="http://192.168.1.5:8080/video"){
                            _videoViewController.setStreamUrl("http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4");
                            setState(() {
                              _camera_url="http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4";
                            });
                            }
                            else if(_camera_url=="http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4"){
                            _videoViewController.setStreamUrl("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
                            setState(() {
                              _camera_url="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
                            });
                            }
                            else{
                               _videoViewController.setStreamUrl("http://192.168.1.5:8080/video");
                            setState(() {
                              _camera_url="http://192.168.1.5:8080/video";
                            });

                            }

                          },

                          // color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white24,
                              ),
                              Text(
                                "Previous",
                                style: TextStyle(color: Colors.white54),
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(150, 250, 0, 0),
                      child: FlatButton(
                          onPressed: () {
                            if(_camera_url=="http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4"){
                            _videoViewController.setStreamUrl("http://192.168.1.5:8080/video");
                            setState(() {
                              _camera_url="http://192.168.1.5:8080/video";
                            });
                            }
                            //
                            else if(_camera_url=="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"){
                            _videoViewController.setStreamUrl("http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4");
                            setState(() {
                              _camera_url="http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_2160p_60fps_normal.mp4";
                            });
                            }
                            else{
                               _videoViewController.setStreamUrl("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
                            setState(() {
                              _camera_url="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
                            });

                            }

                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Next",
                                style: TextStyle(color: Colors.white54),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white24,
                              ),
                            ],
                          )),
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