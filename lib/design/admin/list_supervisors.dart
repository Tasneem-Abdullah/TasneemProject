import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './admin_sidemenue.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/admin.dart';
import './edit_supervisor.dart';

void main() => runApp(Viewsupervisors());

class Viewsupervisors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return viewsupervisorsState();
  }
}

class viewsupervisorsState extends State<Viewsupervisors> {
  Admin admin=new Admin();
  Stream<QuerySnapshot> supervisors_data ;
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
    admin.List_supervisors().then((data){
      setState(() {
        supervisors_data=data;
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
            endDrawer: adminside(),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Supervisors List",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontFamily: "lora",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: 
                    supervisors_data!=null?
                    StreamBuilder(
                        stream: supervisors_data,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot supervisor =
                                        snapshot.data.documents[index];
                                    return filter == null || filter == ""
                                        ? new Container(
                                            margin: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
                                              color: Colors.white70,
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Name: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['Name'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Supervision location: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['Location'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'IP Address: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['IP_Address'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Email Address: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['Email'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Phone Number: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['Supervisor_Phone'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: SizedBox(
                                                                width: 150,
                                                                child:
                                                                    FlatButton(
                                                                  //  color: Colors.white,
                                                                  child: Text(
                                                                    'Edit',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          "lora",
                                                                    ),
                                                                  ),
                                                                  shape: new RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          new BorderRadius.circular(
                                                                              10.0)),
                                                                  color: Colors
                                                                      .black87,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (BuildContext context) =>
                                                                                EditSupervisor(supervisor)));
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(15,
                                                                    10, 0, 0),
                                                            child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: SizedBox(
                                                                    width: 150,
                                                                    child:
                                                                        FlatButton(
                                                                      child:
                                                                          Text(
                                                                        'Delete',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.white,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              "lora",
                                                                        ),
                                                                      ),
                                                                      shape: new RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(10.0)),
                                                                      color: Colors
                                                                          .black87,
                                                                      onPressed:
                                                                          () async {
                                                                        admin.Delete_supervisor(supervisor.documentID);
                                                                        await Navigator.of(context).pushAndRemoveUntil(
                                                                            MaterialPageRoute(builder: (context) => Viewsupervisors()),
                                                                            (Route<dynamic> route) => false);
                                                                      },
                                                                    ))),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ]))
                                        : supervisor['Name']
                                                    .toLowerCase()
                                                    .contains(
                                                        filter.toLowerCase()) ||
                                                supervisor['IP_Address']
                                                    .toLowerCase()
                                                    .contains(
                                                        filter.toLowerCase())
                                            ? new Container(
                                                margin: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black54),
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Name: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "lora",
                                                                      )),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        supervisor['Name'] ==
                                                                                null
                                                                            ? ''
                                                                            : supervisor[
                                                                                'Name'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Supervision location: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "lora",
                                                                      )),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        supervisor['Location'] ==
                                                                                null
                                                                            ? ''
                                                                            : supervisor[
                                                                                'Location'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'IP Address: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "lora",
                                                                      )),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        supervisor['IP_Address'] ==
                                                                                null
                                                                            ? ''
                                                                            : supervisor[
                                                                                'IP_Address'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Email Address: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "lora",
                                                                      )),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        supervisor['Email'] ==
                                                                                null
                                                                            ? ''
                                                                            : supervisor[
                                                                                'Email'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                                .fromLTRB(20,
                                                                    10, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Phone Number: ',
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
                                                                            .bold,
                                                                    fontFamily:
                                                                        "lora",
                                                                  )),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    supervisor['Supervisor_Phone'] ==
                                                                            null
                                                                        ? ''
                                                                        : supervisor[
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
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 150,
                                                                    child:
                                                                        FlatButton(
                                                                      //  color: Colors.white,
                                                                      child:
                                                                          Text(
                                                                        'Edit',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.white,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              "lora",
                                                                        ),
                                                                      ),
                                                                      shape: new RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(10.0)),
                                                                      color: Colors
                                                                          .black87,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (BuildContext context) => EditSupervisor(supervisor)));
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            15,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: SizedBox(
                                                                        width: 150,
                                                                        child: FlatButton(
                                                                          child:
                                                                              Text(
                                                                            'Delete',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.white,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: "lora",
                                                                            ),
                                                                          ),
                                                                          shape:
                                                                              new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                                                          color:
                                                                              Colors.black87,
                                                                          onPressed:
                                                                              () async {
                                                                            admin.Delete_supervisor(supervisor.documentID);
                                                                            await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Viewsupervisors()),
                                                                                (Route<dynamic> route) => false);
                                                                          },
                                                                        ))),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ]))
                                            : new Container();
                                  });
                          }
                        })
                        :Container()
                        )
                        
              ]),
            )));
  }
}
