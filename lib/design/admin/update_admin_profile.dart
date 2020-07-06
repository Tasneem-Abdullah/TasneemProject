import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/admin.dart';


class edit_admin_profile extends StatefulWidget {
  DocumentSnapshot data;
  edit_admin_profile(this.data);

  @override
  State<StatefulWidget> createState() {
    return edit_admin_profileState();
  }
}

class edit_admin_profileState extends State<edit_admin_profile> {
  

  String _name,_password,_email,_phone;
  final GlobalKey<FormState>_Add_Admin_Form_Key = GlobalKey<FormState>();
  Admin admin=new Admin();

  
  update_admin() async {
    final formdata = _Add_Admin_Form_Key.currentState;
    if(formdata.validate()){
      formdata.save();
      admin.Update_profile({
        'name':_name,
        'e-mail':_email,
        'passward':_password,
        'telephon_number':_phone
      }, widget.data.documentID);
      await Navigator.of(context).pop();
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
                'Edit Profile',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
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
                  key: _Add_Admin_Form_Key,               //This uniquely identifies the Form
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
                                  "Admin's Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),

                              ),

                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Admin's Name",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Name Of The Admin';
                                }
                              },
                              onSaved: (val) {
                                _name = val;
                              },
                              initialValue: widget.data.data['name'],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Admin's IP Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Admin's IP Address",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The IP Address Of The Admin';
                                }
                              },
                              onSaved: (val) {
                                _password = val;
                              },
                              initialValue: widget.data.data['passward'],
                              
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Admin's Email Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Admin's Email Address",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (val) {
                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                   RegExp regex = new RegExp(pattern);
                                if (val.isEmpty) {
                                  return 'Please Enter The Email Address Of The Admin';
                                }
                                else if(!(val.contains(regex))){
                                    return 'Please Enter The Right Format Of Email';
                                  }
                              },
                              onSaved: (val) {
                                _email = val;
                              },
                              initialValue: widget.data.data['e-mail'],
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Admin's phone number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Admin's phone number",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter The Telephon number Of The Admin';
                                }
                                else if (val.length<11) {
                                    return 'Phone number should contains 11 numbers';
                                  }
                              },
                              onSaved: (val) {
                                _phone = val;
                              },
                              initialValue: widget.data.data['telephon_number'],
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
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            color: Colors.black87,
                            onPressed:  update_admin,
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
