import 'package:finalgraduationversion/classes/psychologist.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../email.dart';
import '../about_us.dart';
import 'package:hexcolor/hexcolor.dart';
import './psychologist_list_reports.dart';
import './psychologist_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../classes/psychologist.dart';

class pychologist_side extends StatelessWidget {
  Psychologist psychologist=new Psychologist();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 70,),
        children: <Widget>[
          Divider(
            color: Hexcolor('#2c3e50'),
            thickness: 8.0,
            indent: 9.0,
            endIndent: 9.0,
          ),
          


 Padding(padding:EdgeInsets.only(top:35, right: 40.0, left: 40.0 ), child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text("Home", style: TextStyle(
                  color: Colors.white,fontFamily: "gorgeia"
              ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => psychologist_homepage()
                )
                );
              }
          ),
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
              onPressed: () async{
                Stream<DocumentSnapshot> profile_data=await psychologist.View_Profile('psychologist');

               showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  height: 300.0,
                  width: 360.0,
                  child: ListView(
                    children: <Widget>[
                      
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Profile",
                          style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold,fontFamily: "lora",),
                        ),
                      ),
                      SizedBox(height: 20),
                      StreamBuilder(
                        stream:  profile_data,
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                            if(!snapshot.hasData || !snapshot.data.exists){
                              return Text("There is no data",textAlign: TextAlign.center,);
                            }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              var profile = snapshot.data;
                              return Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text('Name: ',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "lora",
                                                        )),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                         profile['name'] ==
                                                                      null
                                                                  ? ''
                                                                  : profile[
                                                                      'name'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily: "lora",
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text('IP Address: ',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "lora",
                                                        )),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          profile['passward'] ==
                                                                      null
                                                                  ? ''
                                                                  : profile[
                                                                      'passward'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily: "lora",
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Email Address: ',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "lora",
                                                        )),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                           profile['e_mail'] ==
                                                                      null
                                                                  ? ''
                                                                  : profile[
                                                                      'e_mail'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily: "lora",
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Phone Number: ',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "lora",
                                                        )),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                           profile['telephon_number'] ==
                                                                      null
                                                                  ? ''
                                                                  : profile[
                                                                      'telephon_number'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily: "lora",
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

           Padding(padding:EdgeInsets.only(top:15,  right: 40.0, left:40.0), child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: Hexcolor('#2c3e50'),
              child: Text("List Reports", style: TextStyle(
                  color: Colors.white,fontFamily: "gorgeia"
              ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => pychologist_ListReport()
                )
                );
              }
          ),
          ),

          Padding(padding:EdgeInsets.only(top:15,  right: 40.0, left:40.0), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),

            child: Text("Send Us A Mail", style: TextStyle(
                color: Colors.white, fontFamily: "gorgeia"

            ),
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
          Padding(padding:EdgeInsets.only(top:15, bottom: 15.0, right: 40.0, left: 40.0), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),

            child: Text("About Us", style: TextStyle(
                color: Colors.white, fontFamily: "gorgeia"

            ),
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

          Padding(padding:EdgeInsets.only(bottom: 15.0, right:40.0, left: 40.0), child: FlatButton(


            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),
            child: Text("log Out", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
            ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              //side: BorderSide(color: Colors.red)
            ),
            onPressed:()async{
              await psychologist.Logout();
              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              login()),
                                                      (Route<dynamic> route) =>
                                                          false);
            },

          ),
          ),
        ],
      ),
    );

  }
}