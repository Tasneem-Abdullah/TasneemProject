import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../report_show_details.dart';
import './psychologist_sidemenue.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/psychologist.dart';

void main()=>runApp(pychologist_ListReport());


class pychologist_ListReport extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return pychologist_ListReportState();
  }
}

class pychologist_ListReportState extends State<pychologist_ListReport> {
  Stream<QuerySnapshot> reports_data ;
  TextEditingController controller = new TextEditingController();
  String filter;
  Psychologist psychologist=new Psychologist();

  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    psychologist.List_reports().then((data){
      setState(() {
        reports_data=data;
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
                ),
                elevation: 0.0,
                iconTheme: new IconThemeData(color: Colors.black),

              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.view_column,color: Colors.black54,),
              //   )
              // ],
              
            ),
            endDrawer:pychologist_side(),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Reports List",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontFamily: "lora",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: 
                  reports_data!=null?
                  StreamBuilder(
                stream: reports_data,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}'); 
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data.documents.length),
                      itemBuilder: (BuildContext context, int index)  {
                        DocumentSnapshot reports =
                                snapshot.data.documents[index];
                                Timestamp t =
                                            reports['date_time'];
                                        DateTime date = t.toDate();
                            return filter == null || filter == ""
                                ? new Container(
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
                                              child:  Text(reports['bullyer'],
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
                                              child: Text(reports['victim'],
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
                                              child: Text(reports['supervisor_name'],
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
                        )
                        : "${date.day}:${date.month}:${date.year}".toLowerCase().contains(filter.toLowerCase()) ||
                         reports['victim'].toLowerCase().contains(filter.toLowerCase()) ||
                     reports['bullyer'].toLowerCase().contains(filter.toLowerCase())
                                    ? new Container(
                          //height: 200,
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
                                              child:  Text(reports['bullyer'],
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
                                              child: Text(reports['victim'],
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
                                              child: Text(reports['supervisor_name'],
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
                        )
                         : new Container();



                      });
                       }
                })
                :Container()
            )
            
             
            ]),
            )
    ));
  }
}