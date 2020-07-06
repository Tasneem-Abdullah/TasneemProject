import 'package:flutter/material.dart';
import './list_supervisors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../classes/admin.dart';
import 'package:hexcolor/hexcolor.dart';



class EditSupervisor extends StatefulWidget {
  DocumentSnapshot data;
  EditSupervisor(this.data);

  @override
  State<StatefulWidget> createState() {
    return EditSupervisorState();
  }
}

class EditSupervisorState extends State<EditSupervisor> {
  Admin admin=new Admin();
  List<String>floors=["Floor 1","Floor 2","Floor 3"];
  String _supervisor_name,_supervisor_ipaddress,_supervisor_email,_choosenfloor,_supervisor_phone;
  final GlobalKey<FormState>_Add_Supervisor_Form_Key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

   
      setState(() {
        _choosenfloor=widget.data.data['Location'];
      });
    
  
  }

  
  add_supervisor() async {
    final formdata = _Add_Supervisor_Form_Key.currentState;
    if(formdata.validate()){
      formdata.save();
      // if(_choosenfloor==null){
      //   _choosenfloor=widget.data.data['Location'];
      // }
      admin.Update_supervisor({
        'Name':_supervisor_name,
        'Email':_supervisor_email,
        'IP_Address':_supervisor_ipaddress,
        'Location':_choosenfloor,
        'Supervisor_Phone':_supervisor_phone,
      }, widget.data.documentID);
      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Viewsupervisors()), (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Bullying detection system',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Hexcolor('#2c3e50'),
              title: Text(
                'Edit Supervisor',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lora"
                ),
              ),
              centerTitle: true,
              leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: ListView(
              children: <Widget>[
                Form(
                  key: _Add_Supervisor_Form_Key,               //This uniquely identifies the Form
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
                                  "Supervisor's Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),

                              ),

                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Supervisor's Name",
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.white,fontFamily: "lora"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Name Of The Supervisor';
                                }
                              },
                              onSaved: (val) {
                                _supervisor_name = val;
                              },
                              initialValue: widget.data.data['Name'],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Supervisor's Ip Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Supervisor's Ip Address",
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white,fontFamily: "lora"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The IP Address Of The Supervisor';
                                }
                              },
                              onSaved: (val) {
                                _supervisor_ipaddress = val;
                              },
                              initialValue: widget.data.data['IP_Address'],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Supervisor's Email Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Supervisor's Email Address",
                                hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.white,fontFamily: "lora"),
                              validator: (val) {
                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                   RegExp regex = new RegExp(pattern);
                                if (val.isEmpty) {
                                  return 'Please Enter The Email Address Of The Supervisor';
                                }
                                else if(!(val.contains(regex))){
                                    return 'Please Enter The Right Format Of Email';
                                  }
                              },
                              onSaved: (val) {
                                _supervisor_email = val;
                              },
                              initialValue: widget.data.data['Email'],
                            ),

                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Supervisor's Phone Number",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "lora"
                                    ),
                                  ),
                                ),

                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter Supervisor's Phone Number",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  fillColor: Colors.black26,
                                  filled: true,
                                ),
                                keyboardType: TextInputType.number, 
                                style: TextStyle(color: Colors.white,fontFamily: "lora"),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Please Enter The Phone Number Of The Supervisor';
                                  }
                                  else if (val.length<11) {
                                    return 'Phone number should contains 11 numbers';
                                  }
                                },
                                onSaved: (val) {
                                  _supervisor_phone = val;
                                },

                                initialValue: widget.data.data['Supervisor_Phone'],
                              ),

                          ],
                        ),
                      ),


                      Container(
                        padding: const EdgeInsets.fromLTRB(30,10,30,0),
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Choose From the List below the Place you want your Supervisor to be Assigned to.",
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "PlayGround",
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                              ),

                            ),
                            Divider(
                              color: Colors.white,
                            ),

                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: floors.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    height: 45,
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _choosenfloor="${floors[index]}";
                                    });
                                    print("$_choosenfloor");
                                  },
                                  child: Text("${floors[index]}",
                                  style: TextStyle(
                                    color: _choosenfloor == "${floors[index]}" ? Colors.red : Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "lora"
                                  ),
                                ),
                                ),
                                        Divider(
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  );
                                }
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
                              'Save',
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
                            onPressed:  add_supervisor,
                          )
                      ),
                    ],
                  ),
                ),

              ],
            ),
            )
            ));
  }
}
