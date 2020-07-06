import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



class show_report extends StatefulWidget{
  DocumentSnapshot data;
    show_report(this.data);
  @override
  State<StatefulWidget> createState(){
    return show_reportState();
  }
}

class show_reportState extends State<show_report> {
   Timestamp t ;
    DateTime date ;
     @override
    initState() {
    super.initState();
     t =widget.data.data['date_time'];
     date = t.toDate();
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
              backgroundColor: Hexcolor('#2c3e50'),
              leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "photos/logo.png",
          ),
            ),
              title: Text(
                'View Report',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lora"
                ),
              ),
              centerTitle: true,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Hexcolor('#2c3e50'),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios,color: Colors.lightBlue,),
                        Text("Back",style:TextStyle(color: Colors.lightBlue,fontFamily: "lora") ,)
                      ],
                    )
                ),
              ],
            ),
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
                    child:Text("Hey, Pychologist",
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
                              fontWeight: FontWeight.normal,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text("${date.day}:${date.month}:${date.year}",
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
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text('Time:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Flexible(
                      child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text("${date.hour}:${date.minute}:${date.second}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    )
                    
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text('Bullyer Name: ',
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
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(widget.data.data['bullyer'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "lora"
                                )),
                          ),

                        ),
                  ],
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text('Victum Name: ',
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
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(widget.data.data['victim'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "lora"
                                )),
                          ),

                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text('Supervisor Name: ',
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
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(widget.data.data['supervisor_name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "lora"
                                )),
                          ),

                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Text('Event details: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 16),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(widget.data.data['event'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontFamily: "lora"
                              )),
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Text('Action taken: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lora"
                            )),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 16),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(widget.data.data['action'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontFamily: "lora"
                              )),
                        ),

                      ),
                    ),
                    
                    ],
    )
    ]),
            )));

  }
}
