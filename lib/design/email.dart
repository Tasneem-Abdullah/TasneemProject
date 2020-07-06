import 'package:flutter/material.dart';
import 'admin/admin_sidemenue.dart';
import 'supervisor/supervisor_sidemenu.dart';
import '../classes/personel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'psychologist/psychologist_sidemenue.dart';

class email extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Email();
  }
}

class Email extends State<email> {
  final GlobalKey<FormState> _Add_email_Form_Key = GlobalKey<FormState>();
  String user_id, admin, supervisor, pychologist, _from_email, _message_body;
  Personel person=new Personel();

  @override
  initState() {
    super.initState();

    person.getCurrentUser().then((data) {
      setState(() {
        user_id = data;
      });
      person.is_admin(user_id).then((data) {
        setState(() {
          admin = data;
          // print("adim home = $admin");
        });
      });

      person.is_supervisor(user_id).then((data) {
        setState(() {
          supervisor = data;
          //  print(" supervisor home = $supervisor");
        });
      });

      person.is_pychologist(user_id).then((data) {
        setState(() {
          pychologist = data;
          //  print(" supervisor home = $supervisor");
        });
      });

      // print("id==$user_id");
    });
  }

  Future<void> sendMessage() async {
    final formdata = _Add_email_Form_Key.currentState;
    if (formdata.validate()) {
      formdata.save();

      person.Send_Us_Email({'from': _from_email, 'body_of_message': _message_body});

      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => email()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
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
          endDrawer:
              admin == "true" && supervisor == "false" && pychologist == 'false'
                  ? adminside()
                  : admin == "false" &&
                          supervisor == "true" &&
                          pychologist == 'false'
                      ? superside()
                      : pychologist_side(),
          body: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
            child: ListView(children: <Widget>[
              Form(
                key: _Add_email_Form_Key,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Send Us A Mail',
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontFamily: "lora",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, right: 15, left: 15.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          maxLength: 30,
                          autofocus: false,
                          style: TextStyle(fontSize: 15, color: Colors.white,fontFamily: "lora"),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black26),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: "Enter Your Email Address",
                            hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                          ),
                          validator: (val) {
                            Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                   RegExp regex = new RegExp(pattern);
                            if (val.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                            else if(!(val.contains(regex))){
                                    return 'Please Enter The Right Format Of Email';
                                  }
                          },
                          onSaved: (val) {
                            _from_email = val;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.only(right: 15, left: 15.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          maxLength: 1000,
                          maxLines: 15,
                          autofocus: false,
                          style: TextStyle(fontSize: 15, color: Colors.white,fontFamily: "lora"),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black26),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: "Enter Your Email Contet Here",
                            hintStyle: TextStyle(color: Colors.white,fontFamily: "lora"),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please Enter The Content Of The Email';
                            }
                          },
                          onSaved: (val) {
                            _message_body = val;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15.0, right: 15, left: 15.0),
                      child: FlatButton(
                        padding: EdgeInsets.only(
                            top: 15, right: 30, left: 30, bottom: 15),
                        color: Colors.black26,
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: "lora"
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0)),
                        onPressed: sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
