import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import './supervisor_sidemenu.dart';
import '../../classes/supervisor.dart';
import '../report_show_details.dart';
import './update_report.dart';

void main()=>runApp(ListReport());


class ListReport extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return ListReportState();
  }
}

class ListReportState extends State<ListReport> {
   Stream<QuerySnapshot> supervisor_reports;
  TextEditingController controller = new TextEditingController();
  String filter;
  String user_id ;
  Supervisor sup=new Supervisor();

  @override
  initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });

    sup.List_reports().then((data){
      setState(() {
        supervisor_reports=data;
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
              leading: Icon(Icons.star,color: Colors.black),
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
                )


            ),
             endDrawer: superside(),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child:Column(
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
                        fontFamily: "lora"
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: supervisor_reports,
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
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot reports =
                                snapshot.data.documents[index];
                                Timestamp t = reports['date_time'];
                                        DateTime date = t.toDate();
                              return filter == null || filter == ""
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
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['victim'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                          child: Text('Supervision Location: ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['supervisor_location'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['supervisor_name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      
                                        Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("${date.day}:${date.month}:${date.year}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      
                                       Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("${date.hour}:${date.minute}:${date.second}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "lora"
                                          )),
                                    ),

                                  ),
                                      
                                      
                                ],
                              ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 120,
                                                child: FlatButton(
                                                  //  color: Colors.white,
                                                  child: Text(
                                                    'Show Details',
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
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: 80,
                                            child: FlatButton(
                                              //  color: Colors.white,
                                              child: Text(
                                                'Edit',
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
                                              onPressed:  () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                         UpdateReport(
                                                                            reports)));
                                                          },
                                            ),
                                          ),
                                        ),

                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                              width: 90,
                                              child:FlatButton(
                                                //  color: Colors.white,
                                                child: Text(
                                                  'Delete',
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
                                                onPressed:   () async {
                                                                sup.Delete_report(reports.documentID);
                                                                await Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ListReport()),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                              )
                                          )
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
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['victim'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                          child: Text('Supervision Location: ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['supervisor_location'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(reports['supervisor_name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      
                                        Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("${date.day}:${date.month}:${date.year}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "lora"
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
                                                fontFamily: "lora"
                                              )),
                                        ),

                                      ),
                                      
                                       Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("${date.hour}:${date.minute}:${date.second}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "lora"
                                          )),
                                    ),

                                  ),
                                      
                                      
                                ],
                              ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 120,
                                                child: FlatButton(
                                                  //  color: Colors.white,
                                                  child: Text(
                                                    'Show Details',
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
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: 80,
                                            child: FlatButton(
                                              //  color: Colors.white,
                                              child: Text(
                                                'Edit',
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
                                              onPressed:  () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                         UpdateReport(
                                                                            reports)));
                                                          },
                                            ),
                                          ),
                                        ),

                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                              width: 90,
                                              child:FlatButton(
                                                //  color: Colors.white,
                                                child: Text(
                                                  'Delete',
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
                                                onPressed:   () async {
                                                                sup.Delete_report(reports.documentID);
                                                                await Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ListReport()),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                              )
                                          )
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
                  }})
            )],
            ) ,
            )
            
            
        ));

  }
}