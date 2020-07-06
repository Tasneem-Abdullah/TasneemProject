import 'package:flutter/material.dart';
import './admin_sidemenue.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../classes/admin.dart';

void main() => runApp(AddPsychologist());

class AddPsychologist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPsychologiststate();
  }
}

class AddPsychologiststate extends State<AddPsychologist> {
  Admin admin=new Admin();
  String _name,_password,_email,_phone;
  final GlobalKey<FormState>_Add_Psychologist_Form_Key = GlobalKey<FormState>();
  add_Psychologist() async {
    final formdata = _Add_Psychologist_Form_Key.currentState;

    if(formdata.validate() ){
      formdata.save();
 
      await admin.Add_psychologist({
        'name':_name,
        'e_mail':_email,
        'passward':_password,
        'telephon_number':_phone,
        
      });
      
      await Navigator.push(context,MaterialPageRoute(builder: (
        BuildContext context)=>AddPsychologist()
        ));

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
              backgroundColor: Hexcolor('#2c3e50'),
              leading: Icon(Icons.star,color: Colors.black),
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Colors.black),
              title: Text(
                'Add Psychologist',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,
                    color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lora"
                ),
              ),
              centerTitle: true,
            ),
            endDrawer: adminside(),
            body: Container(
               decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child: ListView(
              children: <Widget>[
                   Form(
                    key: _Add_Psychologist_Form_Key,               //This uniquely identifies the Form
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
                                    "Psychologist's Name",
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
                                  hintText: "Enter Psychologist's Name",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  fillColor: Colors.black26,
                                  filled: true,
                                  
                                ),
                                style: new TextStyle(color: Colors.white,fontFamily: "lora"),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Please Enter The Name Of The Psychologist';
                                  }
                                },
                                onSaved: (val) {
                                  _name = val;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Supervisor's IP Address",
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
                                  hintText: "Enter Psychologist's IP Address",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  fillColor: Colors.black26,
                                  filled: true,
                                ),
                                keyboardType: TextInputType.number,
                                style: new TextStyle(color: Colors.white,fontFamily: "lora"),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Please Enter The IP Address Of The Psychologist';
                                  }
                                },
                                onSaved: (val) {
                                  _password = val;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Psychologist's Email Address",
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
                                  hintText: "Enter Psychologist's Email Address",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  fillColor: Colors.black26,
                                  filled: true,
                                ),
                                style: new TextStyle(color: Colors.white,fontFamily: "lora"),
                                validator: (val) {
                                  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                   RegExp regex = new RegExp(pattern);
                                  if (val.isEmpty) {
                                    return 'Please Enter The Email Address Of The Psychologist';
                                  }
                                  else if(!(val.contains(regex))){
                                    return 'Please Enter The Right Format Of Email';
                                  }
                                },
                                onSaved: (val) {
                                  _email = val;
                                },
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Psychologist's Phone Number",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      fontFamily: "lora"
                                    ),
                                  ),
                                ),

                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter Psychologist's phone number",
                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                                  fillColor: Colors.black26,
                                  filled: true,
                                ),
                                keyboardType: TextInputType.number,
                                style: new TextStyle(color: Colors.white,fontFamily: "lora"),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Please Enter The phone number Of The Supervisor';
                                  }
                                  else if (val.length<11) {
                                    return 'Phone number should contains 11 numbers';
                                  }
                                },
                                onSaved: (val) {
                                  _phone = val;
                                },
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


                // Text(_choosenfloor==null?"bravoooooooo":null),
                        SizedBox(
                            width: 200,
                            height: 50,
                            child:FlatButton(
                              //  color: Colors.white,
                              child: Text(
                                'Add Psychologist',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "lora"
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0)),
                              color: Colors.black87,
                              onPressed:  add_Psychologist,
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
