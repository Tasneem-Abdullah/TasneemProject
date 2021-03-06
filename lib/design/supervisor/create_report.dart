import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './supervisor_sidemenu.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/supervisor.dart';
import './supervisor_list_reports.dart';



class supervisor_createreport extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return supervisor_createreportState();
  }
}

class supervisor_createreportState extends State<supervisor_createreport> {
   DocumentSnapshot supervisor;
   String user_id;
  Supervisor sup=new Supervisor();
  String _bullyer_name,_victim_name,_event_details,_event_action, _timeString, _date;

  final GlobalKey<FormState>_Add_Report_Form_Key = GlobalKey<FormState>();

  void initState(){
    super.initState();
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
    _date = "${DateTime.now().day} : ${DateTime.now().month} :${DateTime.now().year}";

    sup.Get_supervision_data().then((data){
      setState(() {
        supervisor=data;
      });
    });
    sup.getCurrentUser().then((data){
      setState(() {
        user_id=data;
      });
    });

    


    
    
    
  }
  void _getCurrentTime()  {
    setState(() {
      _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }

     
    
 
  add_report() async {
    final formdata = _Add_Report_Form_Key.currentState;
    
    
    if(formdata.validate()){
      formdata.save();
      sup.Create_report({
        'bullyer' : _bullyer_name,
        'victim' : _victim_name,
        'event' :_event_details,
        'action' :_event_action,
        'date_time':DateTime.now(),
        'supervisor_id' : user_id,
        'supervisor_name' : supervisor.data['Name'],
        'supervisor_location' : supervisor.data['Location']
      });

      await Navigator.push(context,MaterialPageRoute(builder: (
        BuildContext context)=>ListReport()
        ));
    }
  }

  showdata(){
    if (supervisor == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
        child: Align(
          alignment: Alignment.center,
          child: Text('Please wait while load page',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontFamily: "lora"
              )),
        ),
      );
    }
    else{
      return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Align(
                    alignment: Alignment.center,
                    child:Text('Hi , ${supervisor.data['Name']}',
                      style: TextStyle(fontSize: 25,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontFamily: "lora"

                      ),),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text('Date:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text(_date,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text('Time:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Flexible(
                      child:Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text(_timeString,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              fontFamily: "lora"
                            ),


                        ),
                      ),

                    ),
                    )
                    
                  ],
                ),
                Form(
                  key: _Add_Report_Form_Key,               //This uniquely identifies the Form
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30,5,30,10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Bullyer Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),

                              ),

                            ),

                            TextFormField(
                                cursorColor: Colors.black,
                                maxLength: 30,
                                autofocus: false,
                                style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: "lora"),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                    borderSide: BorderSide(width: 2,color: Colors.black26),
                                  ),
                                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),


                                  hintText: "Enter the bullyer name",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),

                                ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Name Of The bullyer';
                                }
                              },
                              onSaved: (val) {
                                _bullyer_name = val;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Victim Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              maxLength: 30,
                              autofocus: false,
                              style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: "lora"),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(9)),
                                  borderSide: BorderSide(width: 2,color: Colors.black26),
                                ),
                                border:OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),


                                hintText: "Enter the victim  name",
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),

                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Name Of The Victum';
                                }
                              },
                              onSaved: (val) {
                                _victim_name = val;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Event Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                                cursorColor: Colors.black,
                                autofocus: false,
                                style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: "lora"),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                    borderSide: BorderSide(width: 2,color: Colors.black26),
                                  ),
                                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),


                                  hintText: "Enter the bullying event details",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  contentPadding: new EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),

                                ),

                              maxLines: null,
                              maxLength: null,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Event Details';
                                }
                              },
                              onSaved: (val) {
                                _event_details = val;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Action Taken:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              autofocus: false,
                              style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: "lora"),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(9)),
                                  borderSide: BorderSide(width: 2,color: Colors.black26),
                                ),
                                border:OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),


                                hintText: "Enter the action taken",
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                contentPadding: new EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),

                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Action Taken To Solve The Event';
                                }
                              },
                              onSaved: (val) {
                                _event_action = val;
                              },
                            ),


                          ],
                        ),
                      ),


//                      Container(
//                        padding: const EdgeInsets.fromLTRB(30,10,30,0),
//                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                        decoration: BoxDecoration(
//                          color: Colors.black54,
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//
//                        child: Column(
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
//                              child: Align(
//                                alignment: Alignment.center,
//                                child: Text(
//                                  "Choose From the List below the Place you want your Supervisor to be Assigned to.",
//                                  style: TextStyle(
//                                    color: Colors.white38,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 16,
//                                  ),
//                                ),
//                              ),
//
//                            ),
//                            Padding(
//                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
//                              child: Align(
//                                alignment: Alignment.center,
//                                child: Text(
//                                  "PlayGround",
//                                  style: TextStyle(
//                                    color: Colors.indigo,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 20,
//                                  ),
//                                ),
//                              ),
//
//                            ),
//                            Divider(
//                              color: Colors.white,
//                            ),
//
//                            ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: 3,
//                                itemBuilder: (BuildContext context, index) {
//                                  return Container(
//                                    height: 40,
//                                    child: Column(
//                                      children: <Widget>[
//                                        Text("Floor 1",
//                                          style: TextStyle(
//                                            color: Colors.indigo,
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 20,
//                                          ),
//                                        ),
//                                        Divider(
//                                          color: Colors.white,
//                                        )
//                                      ],
//                                    ),
//                                  );
//                                }
//                            ),
//
//                          ],
//                        ),
//                      ),
                      SizedBox(
                          width: 250,
                          height: 50,
                          child:FlatButton(
                            //  color: Colors.white,
                            child: Text(
                              'Submit Rrport',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontFamily: "lora"
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            color: Colors.black87,
                            onPressed:  add_report,
                          )
                      ),
                    ],
                  ),
                ),

              ],
            );
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        title: 'Bullying detection system',
        home: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.star,color: Colors.black),
              backgroundColor: Hexcolor('#2c3e50'),
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Colors.black),
              title: Text(
                'Create Report',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lora"
                ),
              ),
              centerTitle: true,
            ),
            endDrawer: superside(),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: showdata(),
            )
            
            
            
            
            
            
            
            
            ));
  }
}
