import 'dart:async';
import 'package:flutter/material.dart';
import './supervisor_sidemenu.dart';
import '../../classes/supervisor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './supervisor_list_reports.dart';
import 'package:hexcolor/hexcolor.dart';





class UpdateReport extends StatefulWidget{
  DocumentSnapshot document;
  UpdateReport(this.document);
  @override
  State<StatefulWidget> createState(){
    return Update();
  }
}

class Update extends State<UpdateReport> {
  Supervisor sup=new Supervisor();
  String _bullyer_name,_victim_name,_event_details,_event_action, _timeString, _date;

  final GlobalKey<FormState>_Add_Report_Form_Key = GlobalKey<FormState>();

  void initState(){
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
    _date = "${DateTime.now().day} : ${DateTime.now().month} :${DateTime.now().year}";
    super.initState();
  }
  void _getCurrentTime()  {
    setState(() {
      _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }

 


  update_report() async {
    final formdata = _Add_Report_Form_Key.currentState;
    if(formdata.validate()){
      formdata.save();
      
      sup.Update_report({
        'bullyer' : _bullyer_name,
        'victim' : _victim_name,
        'event' :_event_details,
        'action' :_event_action,
        'date_time':DateTime.now(),
        'supervisor_id' : widget.document.data['supervisor_id'],
        'supervisor_name' : widget.document.data['supervisor_name'],
        'supervisor_location' : widget.document.data['supervisor_location']
        
      },widget.document.documentID);

      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          ListReport()), (Route<dynamic> route) => false);

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
              leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
              backgroundColor: Hexcolor('#2c3e50'),
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Colors.black),
              title: Text(
                'Edit Report',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lora",
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
              child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Align(
                    alignment: Alignment.center,
                    child:Text("Hey, ${widget.document.data['supervisor_name']}",
                      style: TextStyle(fontSize: 25,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontFamily: "lora",

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
                              fontFamily: "lora",
                            )),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text(_date,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
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
                        child:Text('Time:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora",
                            )),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text(_timeString,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                            fontFamily: "lora",
                          ),


                        ),
                      ),

                    ),
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
                                    fontFamily: "lora",
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
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora",),

                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Name Of The bullyer';
                                }
                              },
                              onSaved: (val) {
                                _bullyer_name = val;
                              },
                              initialValue: widget.document.data['bullyer'],
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
                              initialValue: widget.document.data['victim'],
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
                              initialValue: widget.document.data['event'],
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
                              initialValue: widget.document.data['action'],
                            ),


                          ],
                        ),
                      ),


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
                            onPressed:  update_report,
                          )
                      ),
                    ],
                  ),
                ),

              ],
            ),
            )));
  }
}
