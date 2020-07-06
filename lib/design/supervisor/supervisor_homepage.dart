import '../advices.dart';
import '../ChewieListItem.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../classes/supervisor.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './supervisor_sidemenu.dart';
import './supervisor_live_camera.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

void main() => runApp(supervisor_homepage());

class supervisor_homepage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return supervisor_homepagestate();
  }
}

class supervisor_homepagestate extends State<supervisor_homepage> {
  Stream<QuerySnapshot> bullying_videos;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final dataKey = new GlobalKey();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Supervisor sup=new Supervisor();
  String supervision_location;
  DateTime pastweek = DateTime.now().subtract(Duration(days: 7));

  @override
  initState() {
    super.initState();
    sup.Get_supervision_location().then((data){
   setState((){
     supervision_location=data;
     
   });
   
   sup.List_lastweek_videos(supervision_location).then((data) {
      setState(() {
        bullying_videos=data;
      });
  });
  sup.save_token(supervision_location);

 });
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        FlutterRingtonePlayer.play(
                      android: AndroidSounds.notification,
                      ios: IosSounds.glass,
                      volume: 1.0,
                    );
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Show camera'),
                onPressed: () async {
                  String status = await sup
                      .Get_notification_status(message['data']['document_id']);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => live_camera(
                              status, message['data']['document_id'])));
                },
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        FlutterRingtonePlayer.play(
                      android: AndroidSounds.notification,
                      ios: IosSounds.glass,
                      volume: 1.0,
                    );
        print("onLaunch: $message");
        String status =
            await sup.Get_notification_status(message['data']['document_id']);
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    live_camera(status, message['data']['document_id'])));
      },
      onResume: (Map<String, dynamic> message) async {
        FlutterRingtonePlayer.play(
                      android: AndroidSounds.notification,
                      ios: IosSounds.glass,
                      volume: 1.0,
                    );
        print("onResume: $message");
        String status =
            await sup.Get_notification_status(message['data']['document_id']);
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    live_camera(status, message['data']['document_id'])));
      },
    );
 



  
  }

  
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        title: 'Bullying detection system',
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                  child:Image.asset(
                 'photos/logo.png',
                  fit: BoxFit.contain,
                  height: 32,
              ),
                ),
              
            ],

          ),
            backgroundColor: Hexcolor('#2c3e50'),
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.black),
          ),
          endDrawer: superside(),
          body: SingleChildScrollView(
            child: Container(
              constraints: new BoxConstraints(minHeight: 700),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: Column(children: <Widget>[
                bullying_videos != null
                    ? StreamBuilder(
                        stream: bullying_videos,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Container();
                            default:
                              return new Container(
                                child: Column(
                                  children: <Widget>[
                                    snapshot.data.documents.length != 0
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Bullying History",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white,
                                                fontFamily: "lora",
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            (snapshot.data.documents.length),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          DocumentSnapshot bullying_data =
                                              snapshot.data.documents[index];
                                          Timestamp t =
                                              bullying_data['date_time'];
                                          DateTime date = t.toDate();

                                          return new Container(
                                              margin: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black54),
                                                color: Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    // height: 300,
                                                    // width: 200,
                                                    child: ChewieListItem(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .network(
                                                        bullying_data[
                                                            'video_link'],
                                                      ),
                                                      looping: true,
                                                    ),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Date: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora")),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  "${date.day}:${date.month}:${date.year}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          "lora")),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Time: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora")),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  "${date.hour}:${date.minute}:${date.second}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          "lora")),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Location: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora")),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(bullying_data['location'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          "lora")),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Status: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora")),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(bullying_data['status'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          "lora")),
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                ],
                                              ));
                                        })
                                  ],
                                ),
                              );
                          }
                        })
                    : new Container(),
                Container(
                  key: dataKey,
                  child: advices().advices_design(),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: new RaisedButton(
              onPressed: () => Scrollable.ensureVisible(dataKey.currentContext),
              color: Hexcolor('#2c3e50'),
              child: Text("Go To Advices",
                  style: TextStyle(color: Colors.white, fontFamily: "lora"),
                  textAlign: TextAlign.center)),
        ));
  }
}
