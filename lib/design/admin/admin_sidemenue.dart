import 'package:flutter/material.dart';
import './admin_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login.dart';
import '../email.dart';
import '../about_us.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/admin.dart';
import './update_admin_profile.dart';
import './list_bullying_videos.dart';
import './Addsupervisors.dart';
import './list_supervisors.dart';
import './Addpsychologist.dart';
import './list_psychologist.dart';
import './admin_live_camera.dart';


class adminside extends StatelessWidget {
  Admin admin=new Admin();
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
                    builder: (context) => admin_homepage()
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
                
                Stream<DocumentSnapshot> profile_data=await admin.View_Profile('admin');

               showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  height: 400.0,
                  width: 360.0,
                  child: ListView(
                    children: <Widget>[
                      
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Profile",
                          style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold,fontFamily: "lora"),
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
                                                           profile['e-mail'] ==
                                                                      null
                                                                  ? ''
                                                                  : profile[
                                                                      'e-mail'],
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
                                            Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 20, 0, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: SizedBox(
                                                            width: 200,
                                                            child: FlatButton(
                                                              //  color: Colors.white,
                                                              child: Text(
                                                                'Update Profile',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                          fontFamily: "lora"
                                                                ),
                                                              ),
                                                              shape: new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          10.0)),
                                                              color: Colors
                                                                  .black87,
                                                              onPressed:
                                                               (){
                                                                 Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (BuildContext
                                                                                        context) =>
                                                                                    edit_admin_profile(
                                                                                        profile)));
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                             
                                           
                                            
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

          Padding(padding:EdgeInsets.only(top:15, right: 40.0, left: 40.0 ), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),
            child: Text("live video", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return live_camera();
                  },
                ),
              );
            },
          ),
          ),


          Padding(padding:EdgeInsets.only(top:15, right: 40.0, left: 40.0 ), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),
            child: Text("Bullying videos", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return show_bullying_videos();
                  },
                ),
              );
            },
          ),
          ),


          Padding(padding:EdgeInsets.only(top:15, bottom: 15.0, right: 40.0, left: 40.0 ), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),
            child: Text("Add Supervisor", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return Addsupervisors();
                  },
                ),
              );
            },
          ),
          ),

          Padding(padding:EdgeInsets.only( right:40.0, left:40.0,bottom: 40.0), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),

            child: Text("list Supervisors", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return Viewsupervisors();
                  },
                ),
              );
            },
          ),
          ),


          Padding(padding:EdgeInsets.only( top:15, bottom: 15.0, right: 40.0, left: 40.0), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color:Hexcolor('#2c3e50'),

            child: Text("Add pychologist", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return AddPsychologist();
                  },
                ),
              );
            },
          ),
          ),


          Padding(padding:EdgeInsets.only( right:40.0, left:40.0,bottom: 40.0), child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: Hexcolor('#2c3e50'),

            child: Text("List pychologists", style: TextStyle(
                color: Colors.white,fontFamily: "gorgeia"
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
                    return ListPsychologist();
                  },
                ),
              );
            },
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

          Padding(padding:EdgeInsets.only( bottom: 15.0, right:40.0, left: 40.0), child: FlatButton(


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
              await admin.Logout();
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