import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import '../advices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../classes/psychologist.dart';
import '../report_show_details.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import './psychologist_sidemenue.dart';

void main() => runApp(psychologist_homepage());

class psychologist_homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return pychologist_homepagestate();
  }
}

class pychologist_homepagestate extends State<psychologist_homepage> {
   DateTime pastweek = DateTime.now().subtract(Duration(days: 7));
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final dataKey = new GlobalKey();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String user_id;
  Stream<QuerySnapshot> bullying_reports;
  Psychologist psychologist=new Psychologist();

  @override
  void initState() {
    super.initState();
    
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
                child: Text('View report'),
                onPressed: () async {
                  DocumentSnapshot notification_report=await psychologist.Get_report(message['data']['document_id']);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => show_report(
                             notification_report)));
                },
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        
       DocumentSnapshot notification_report=await psychologist.Get_report(message['data']['document_id']);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => show_report(
                             notification_report)));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
       DocumentSnapshot notification_report=await psychologist.Get_report(message['data']['document_id']);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => show_report(
                             notification_report)));
      },
    );
    psychologist.List_lastweek_reports().then((data){
      setState(() {
        bullying_reports=data;
      });
    });
    psychologist.save_token("psychologist");
    

  }
  


 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        title: 'Bullying detection system',
        home: Scaffold(
            appBar: AppBar(
              leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "photos/logo.png",
          ),
            ),
              backgroundColor: Hexcolor('#2c3e50'),
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Colors.black),
            ),
             endDrawer:pychologist_side(),
            body: SingleChildScrollView(
child: Container(
  constraints: new BoxConstraints(
    minHeight: 700
  ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: Column(children: <Widget>[
               
                   
                bullying_reports!=null?
                      StreamBuilder(
                            stream: bullying_reports,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return new Text('Loading...');
                                default:
                                  return new Column(
                                    children: <Widget>[
                                      snapshot.data.documents.length!=0?
                                      Align(
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
                      ):Container(),

                      ListView.builder(
                                      shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          (snapshot.data.documents.length),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                         DocumentSnapshot reports =
                                snapshot.data.documents[index];
                                Timestamp t =
                                            reports['date_time'];
                                        DateTime date = t.toDate();

                                        return new Container(
                            margin: EdgeInsets.all(10.0),
                            decoration:
                            BoxDecoration(border: Border.all(color: Colors.black54),
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:  Text('Bully Name: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          Flexible(
                                                    child: Padding(
                                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:  Text(reports['bullyer']!=null?reports['bullyer']:'',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          )

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Victim Name: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          Flexible(
                                                    child:Padding(
                                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(reports['victim']!=null?reports['victim']:'',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          )

                                        ],
                                      ),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Supervisor Name: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          Flexible(
                                                    child:Padding(
                                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(reports['supervisor_name']!=null?reports['supervisor_name']:'',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          )

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Date: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                         Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${date.day}:${date.month}:${date.year}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Time: ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          Flexible(
                                                    child:Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${date.hour}:${date.minute}:${date.second}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "lora",
                                                  )),
                                            ),

                                          ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 250,
                                                child: FlatButton(
                                                  //  color: Colors.white,
                                                  child: Text(
                                                    'Show Details',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "lora",
                                                    ),
                                                  ),
                                                  shape: new RoundedRectangleBorder(
                                                      borderRadius: new BorderRadius.circular(10.0)),
                                                  color: Colors.black87,
                                                  onPressed:  (){
                                                     Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        show_report(
                                                                            reports)));
                                                  },
                                                ),
                                              ),
                                            ),

                                          ),
                                        ],
                                      )

                                    ],
                                  )

                                ]
                            )
                        );
                                      })

                                    ],
                                  );
                                  
                                  
                              }
                            })
                            
                            :Container(),

                           Container(
                              key: dataKey,
                              child:  advices().advices_design(),
                            ),

                       
                    
                
                        
              ]),
            ),
            ),
             bottomNavigationBar: new RaisedButton(
        onPressed: () => Scrollable.ensureVisible(dataKey.currentContext),
        color: Hexcolor('#2c3e50'),
        
    

      
      child: Text("Go To Advices",style: TextStyle(color: Colors.white,fontFamily: "lora",),textAlign: TextAlign.center)
    
        
      ),
            ));
  }
}


