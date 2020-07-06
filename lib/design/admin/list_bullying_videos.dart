import '../ChewieListItem.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import './admin_sidemenue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../classes/admin.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(show_bullying_videos());

class show_bullying_videos extends StatefulWidget {
  @override
  @override
  State<StatefulWidget> createState() {
    return show_bullying_videosState();
  }
}

class show_bullying_videosState extends State<show_bullying_videos> {
  Stream<QuerySnapshot> bullying_videos;
  Admin admin=new Admin();
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    admin.Show_video_history().then((data){
      setState(() {
        bullying_videos=data;
      });
    });
  
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        title: 'Bullying detection system',
        home: Scaffold(
            appBar: AppBar(
                leading: Icon(Icons.star, color: Colors.black),
                backgroundColor: Hexcolor('#2c3e50'),
                elevation: 0.0,
                iconTheme: new IconThemeData(color: Colors.black),
                title: Container(
                  height: 40,
                  width: 500,
                  child: TextField(
                    autofocus: false,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "lora",
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white12.withOpacity(0.1),
                      filled: true,
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(50.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                    ),
                    controller: controller,
                  ),
                )),
            endDrawer: adminside() ,
            body: SingleChildScrollView(
              child: Container(
                  constraints: new BoxConstraints(minHeight: 700),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
                  child: Column(children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Bullying History",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontFamily: "lora"),
                      ),
                    ),
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
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: (snapshot
                                                .data.documents.length),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              DocumentSnapshot bullying_data =
                                                  snapshot
                                                      .data.documents[index];
                                              Timestamp t =
                                                  bullying_data['date_time'];
                                              DateTime date = t.toDate();

                                              return filter == null ||
                                                      filter == ""
                                                  ? new Container(
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black54),
                                                        color: Colors.white70,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            // height: 300,
                                                            // width: 200,
                                                            child:
                                                                ChewieListItem(
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
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Date: ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: "lora")),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          "${date.day}:${date.month}:${date.year}",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "lora")),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Time: ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: "lora")),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          "${date.hour}:${date.minute}:${date.second}",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "lora")),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Location: ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: "lora")),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          bullying_data[
                                                                              'location'],
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "lora")),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Status: ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: "lora")),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          bullying_data[
                                                                              'status'],
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontFamily: "lora")),
                                                                    ),
                                                                  ),
                                                                )
                                                              ]),
                                                        ],
                                                      ))
                                                  : "${date.day}:${date.month}:${date.year}"
                                                              .toLowerCase()
                                                              .contains(filter
                                                                  .toLowerCase()) ||
                                                          bullying_data[
                                                                  'location']
                                                              .toLowerCase()
                                                              .contains(filter
                                                                  .toLowerCase())
                                                      ? new Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black54),
                                                            color:
                                                                Colors.white70,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Container(
                                                                // height: 300,
                                                                // width: 200,
                                                                child:
                                                                    ChewieListItem(
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
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              20,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Text(
                                                                            'Date: ',
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.black,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "lora")),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child: Text(
                                                                              "${date.day}:${date.month}:${date.year}",
                                                                              style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, fontFamily: "lora")),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              20,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Text(
                                                                            'Time: ',
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.black,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "lora")),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child: Text(
                                                                              "${date.hour}:${date.minute}:${date.second}",
                                                                              style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, fontFamily: "lora")),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              20,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Text(
                                                                            'Location: ',
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.black,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "lora")),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child: Text(
                                                                              bullying_data['location'],
                                                                              style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, fontFamily: "lora")),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Text(
                                                                            'Status: ',
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.black,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "lora")),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child: Text(
                                                                              bullying_data['status'],
                                                                              style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, fontFamily: "lora")),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ],
                                                          ))
                                                      : new Container();
                                            })
                                      ],
                                    ),
                                  );
                              }
                            })
                        : new Container(),
                  ])),
            )));
  }
}
