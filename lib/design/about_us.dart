import 'package:flutter/material.dart';
import 'admin/admin_sidemenue.dart';
import '../classes/personel.dart';
import 'supervisor/supervisor_sidemenu.dart';
import 'package:hexcolor/hexcolor.dart';
import 'psychologist/psychologist_sidemenue.dart';


class about extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {


//      State<StatefulWidget> createState() =>
        return aboutus();

  }

}


class aboutus extends State<about>{
    String user_id ,admin,supervisor,pychologist;
  Personel person=new Personel();

  @override
 initState() {
    super.initState();

    person.getCurrentUser().then((data){
      setState(() {
        user_id  = data;
      });
      person.is_admin(user_id).then((data){
      setState(() {
        admin = data;
        // print("adim home = $admin");
      });
    });

    person.is_supervisor(user_id).then((data){
      setState(() {
        supervisor = data;
        //  print(" supervisor home = $supervisor");
      });
    });

    person.is_pychologist(user_id).then((data){
      setState(() {
        pychologist = data;
        //  print(" supervisor home = $supervisor");
      });
    });
      
      // print("id==$user_id");
    });

  
  }
  Widget build(context){


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        appBar:
        AppBar(
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


        endDrawer: admin=="true" && supervisor=="false" && pychologist=='false' ? adminside() 
       : admin=="false" && supervisor=="true" && pychologist=='false' ? superside()
         :pychologist_side()  ,
        body: Container(
          decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Hexcolor('#2c3e50'), Hexcolor('#bdc3c7')])),
          child: ListView(
            children: <Widget>[
              Container(

                padding: EdgeInsets.all(15.0),
                child: Column(
                  //mainAxisAlignment:MainAxisAlignment.center ,
                  children: <Widget>[
                    Text('About Us',
                      style: TextStyle(
                        fontSize:30,
                        fontStyle:FontStyle.italic,
                        fontFamily: "lora",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,


                      ) ,
                    ),
                    Padding(padding:EdgeInsets.only(left: 15.0,right: 15.0, top: 15.0), child:

                      Text("““Bullying can be described as negative activity or"
                          " aggression intended to harm or bother someone who is "
                          "perceived by peers as being less physically or psychologically powerful than the aggressor(s)””",
                      style: TextStyle(
                      fontSize:18,
                      fontStyle:FontStyle.italic,
                      fontFamily: "lora",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,


                    ) ,

                    ),
                    ),
                    Padding(padding:EdgeInsets.only(left: 15.0,right: 15.0, top: 40.0), child:

                    Text("We propose a bullying detection/alert system for school-wide intervention that"
                        " uses only a network of surveillance cameras integrated with deep learning technologies for the bullying act detection.",
                      style: TextStyle(
                        fontSize:18,
                        fontStyle:FontStyle.italic,
                        fontFamily: "lora",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,


                      ) ,

                    ),
                    ),
                    Padding(padding:EdgeInsets.only(left: 15.0,right: 15.0, top: 40.0), child:

                    Text("The system alerts school personnel when potential bullying is detected"
                        " and identifies potential bullying by recognizing actions, emotions, and crowd formations associated with bullying.",
                      style: TextStyle(
                        fontSize:18,
                        fontStyle:FontStyle.italic,
                        fontFamily: "lora",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,


                      ) ,

                    ),
                    ),
                    Padding(padding:EdgeInsets.only(top:15, bottom: 15.0, right: 15, left: 15.0), child: FlatButton(
                      padding: EdgeInsets.only(top:15,right: 30,left: 30,bottom: 15),

                      color: Colors.black87,

                      child: Text("Visit Our Website", style: TextStyle(
                        color: Colors.white,
                        fontFamily: "lora",
                        fontSize: 25,
                          shadows: <Shadow>[
                      Shadow(
                      offset: Offset(7.0, 7.0),
                        blurRadius: 5.0,
                        //color: Color.fromARGB(215, 0, 0, 0),
                      ),
                      ],

                      ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),


                      onPressed: (){
                        Navigator.pushNamed(context, 's');
                      },


                    ),
                    ),

                  ],

                ),
              ), ]
        ),
        )
        
      ),
    );


  }
}
