import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';



class advices  {

 


  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget advices_design(){
    return new  Column(children: <Widget>[   
                       Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Advices",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontFamily: "lora"
                          ),
                        ),
                      ),
                    
                
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8), children: <
                            Widget>[
                  
                  Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/Psych-Professionals-say-no-to-bullying.png"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("How to Prevent Bullying",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/how-to-prevent-bullying");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                          Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/bullying-shutterstock-site.jpeg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Prevention at School",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/at-school");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                          Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 150,
                                        child:
                                            Image.asset("photos/bullying770.png"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Assess Bullying",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/assess-bullying");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                          Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/3333.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Engage Parents & Youth",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/engage-parents");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                          Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/444.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Set Policies & Rules",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/rules");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                          Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 150,
                                        child:
                                            Image.asset("photos/5555.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Build a Safe Environment",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/build-safe-environment");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                           Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/777.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Working in the Community",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/in-the-community");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                           Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/99.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Find Out What Happened",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/find-out-what-happened");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                           Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 150,
                                        child:
                                            Image.asset("photos/90.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Support the Kids Involved",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/support-kids-involved");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                           Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 30, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 150,
                                        child:
                                            Image.asset("photos/9090.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Respond to Bullying",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/on-the-spot");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ])),
                           Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child:
                                            Image.asset("photos/12.jpg"),
                                      ))),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text("Bystanders to Bullying",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "lora"
                                                )),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("See more",style: TextStyle(fontFamily: "lora"),),
                                      onPressed: () {
                                        _launchInBrowser(
                                            "https://www.stopbullying.gov/prevention/bystanders-to-bullying");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ])
                          ]))
                ])
              ]);
            
  }

  
}

