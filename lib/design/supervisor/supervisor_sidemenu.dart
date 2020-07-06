import 'package:flutter/material.dart';
import './supervisor_homepage.dart';
import './supervisor_list_videos.dart';
import '../email.dart';
import '../about_us.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/supervisor.dart';
import '../login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './create_report.dart';
import './supervisor_list_reports.dart';
import './supervisor_live_camera.dart';

class superside extends StatelessWidget {
  Supervisor sup=new Supervisor();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(
          top: 70,
        ),
        children: <Widget>[
          Divider(
            color: Hexcolor('#2c3e50'),
            thickness: 8.0,
            indent: 9.0,
            endIndent: 9.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, right: 40.0, left: 40.0),
            child: FlatButton(
                padding: EdgeInsets.all(15.0),
                color: Hexcolor('#2c3e50'),
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  //side: BorderSide(color: Colors.red)
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => supervisor_homepage()));
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "Show Profile",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () async {
                
                Stream<DocumentSnapshot> profile_data=await sup.View_Profile('supervisor');

                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 320.0,
                        width: 360.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,fontFamily: "lora"),
                              ),
                            ),
                            SizedBox(height: 20),
                            StreamBuilder(
                                stream: profile_data,
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  if (!snapshot.hasData ||
                                      !snapshot.data.exists) {
                                    return Text(
                                      "There is no data",
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return new Text('Loading...');
                                    default:
                                      var profile = snapshot.data;
                                      return Container(
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Name: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "lora",
                                                                )),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  profile['Name'] ==
                                                                          null
                                                                      ? ''
                                                                      : profile[
                                                                          'Name'],
                                                                  style:
                                                                      TextStyle(
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
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Location: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "lora",
                                                                )),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  profile['Location'] ==
                                                                          null
                                                                      ? ''
                                                                      : profile[
                                                                          'Location'],
                                                                  style:
                                                                      TextStyle(
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
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'IP Address: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "lora",
                                                                )),
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
                                                                  profile['IP_Address'] ==
                                                                          null
                                                                      ? ''
                                                                      : profile[
                                                                          'IP_Address'],
                                                                  style:
                                                                      TextStyle(
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
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Email Address: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "lora",
                                                                )),
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
                                                                  profile['Email'] ==
                                                                          null
                                                                      ? ''
                                                                      : profile[
                                                                          'Email'],
                                                                  style:
                                                                      TextStyle(
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
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 10, 0, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Phone Number: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "lora",
                                                                )),
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
                                                                  profile['Supervisor_Phone'] ==
                                                                          null
                                                                      ? ''
                                                                      : profile[
                                                                          'Supervisor_Phone'],
                                                                  style:
                                                                      TextStyle(
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
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]));
                                  }
                                })
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "Create Report",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return supervisor_createreport();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 15, bottom: 15.0, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "List report",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return ListReport();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "live video",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return live_camera('0','0');
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "Bullying videos",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return show_bullying_videos();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "Send Us A Mail",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return email();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 20, bottom: 15.0, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "About Us",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) {
                      return about();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, right: 40.0, left: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text(
                "log Out",
                style: TextStyle(color: Colors.white, fontFamily: "gorgeia"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () async {
                await sup.Logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => login()),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
