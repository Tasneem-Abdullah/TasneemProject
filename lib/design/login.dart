import 'package:flutter/material.dart';
import '../classes/personel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'admin/admin_homepage.dart';
import 'psychologist/psychologist_homepage.dart';
import 'supervisor/supervisor_homepage.dart';

void main() => runApp(login());

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

class loginState extends State<login> {
  Personel person=new Personel();
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  bool loginfail = false;
  String _useremail, _user_ipaddress;
  final GlobalKey<FormState> _login_Form_Key = GlobalKey<FormState>();

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
              
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Colors.black),
              title: Row(
              children: [
                Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                  child:Image.asset(
                 'photos/logo.png',
                  fit: BoxFit.contain,
                  height: 32,
              ),
                ),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

          ),
            ),
            body: Container(
              decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                
                                colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
              child:ListView(
              children: <Widget>[
                Form(
                  key: _login_Form_Key, //This uniquely identifies the Form
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 120, 30, 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "USER E_MAIL",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter User E_mail",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                                errorText: loginfail ? 'email not match' : null,
                              ),
                               style: new TextStyle(color: Colors.white),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter Your E_mail';
                                }
                              },
                              onSaved: (val) {
                                _useremail = val;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "USER IP_ADDRESS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter User Ip Address",
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.black26,
                                filled: true,
                                errorText:
                                    loginfail ? 'password not match' : null,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglevisibility();
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                               style: new TextStyle(color: Colors.white),
                              obscureText: !_showPassword,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter Your IP_Address';
                                }
                              },
                              onSaved: (val) {
                                _user_ipaddress = val;
                              },
                            ),
                            Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                child: SizedBox(
                                    width: 250,
                                    height: 50,
                                    child: FlatButton(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0)),
                                      color: Colors.black87,
                                      onPressed: () async {
                                        try{
                                        final formdata =
                                            _login_Form_Key.currentState;
                                        if (formdata.validate()) {
                                          formdata.save();
                                       String login=await person.Login(_useremail, _user_ipaddress);
                                       if(login=='admin'){
                                         Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              admin_homepage()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                         
                                       }
                                       else if(login=='supervisor'){
                                         Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              supervisor_homepage()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                       }
                                       else if(login=='psychologist'){
                                         Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              psychologist_homepage()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                       }
                                       else if(login=='enemy'){
                                         setState(() {
                                              loginfail = true;
                                            });
                                       }
                                        }
                                       } catch (error) {
                                            setState(() {
                                              loginfail = true;
                                            });
                                            print(error);
                                            print("_username=$_useremail");
                                          }
                                        
                                      },
                                      colorBrightness: Brightness.light,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ) ,
            )
            ));
  }
}
