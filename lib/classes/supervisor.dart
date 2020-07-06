import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalgraduationversion/classes/personel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './video.dart';
import './report.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Supervisor extends Personel{
  String supervision_location;
  Video video=new Video();
  Report report=new Report();

  Supervisor(){}
  void Set_supervision_location(String location){
    this.supervision_location=location;
  }
 
  

  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }

   Future<String> Get_supervision_location()async{
     if(auth()){
       FirebaseUser user = await FirebaseAuth.instance.currentUser();
        String user_id = user.uid;
        DocumentSnapshot supervisor_data = await get_supervisor_data(user_id);
         return supervisor_data.data['Location'];
     }
  }

  Future<DocumentSnapshot> Get_supervision_data()async{
    if(auth()){
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
        String user_id = user.uid;
        DocumentSnapshot supervisor_data = await get_supervisor_data(user_id);
         return supervisor_data;
    }
  }

  Future<bool> Add_supervisor(Map<String,dynamic>data)async{
    if(auth()){
      AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: data['Email'], password: data['IP_Address']);
    FirebaseUser user = result.user;
   await Firestore.instance.collection('Supervisors').document(user.uid).setData(data);
   return true;

    }
    else{
      return false;
    }
  }

  get_supervisor_data(String Supervisor_id) async {
    return await Firestore.instance
        .collection('Supervisors')
        .document(Supervisor_id)
        .get();
  }

  List_lastweek_videos(String supervision_location)async{
    if(auth()){
      return await video.List_lastweek_videos_supervisor(supervision_location);
    }
    
  }
  Show_video_history(String supervision_location)async{
    if(auth()){
      return await video.List_videos_supervisor(supervision_location);
    }
  }
  Future<bool> Delete_supervisor(ID)async{
    if(auth()){
      await Firestore.instance.collection('Supervisors').document(ID).delete();
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> Update_supervisor(data,ID)async{
    if(auth()){
      await Firestore.instance.collection('Supervisors').document(ID).setData(data);
      return true;
    }
    else{
      return false;
    }
    
  }
  List_supervisors()async{
    if(auth()){
      return await Firestore.instance.collection('Supervisors').snapshots();
    }
  }

  Future<bool> Create_report(Map<String,dynamic> data)async{
    if(auth()){
      await report.Create_report(data);
      return true;
    }
    else{
      return false;
    }
  }
   List_reports()async{
     if(auth()){
       String user_id=await getCurrentUser();
      return report.List_reports_supervisor(user_id);
     }
   }
   Future<bool> Update_report(data,ID)async{
     if(auth()){
       await report.Update_report(data, ID);
       return true;
     }
     else{
       return false;
     }
   }

   Future<bool> Delete_report(ID)async{
    if(auth()){
      await report.Delete_report(ID);
      return true;
    }
    else{
      return false;
    }
  }


  Future<String> Open_live_streaming()async{
    if(auth()){
      String location=await Get_supervision_location();
      if(location=="Floor 1"){
        return "http://192.168.1.5:8080/video";
      }
      else if(location=="Floor 2"){
        return "http://192.168.1.5:8080/video";
      }
      else if(location=="Floor 3"){
        return "http://192.168.1.5:8080/video";
      }
    }
  }

  Future<bool> Update_status(status_data,doc_id){
    if(auth()){
      video.Update_status(status_data,doc_id);
    }
  }

  Future<String>Get_notification_status(String doc_id)async{
    if(auth()){
      return await video.Get_notification_status(doc_id);
    }
  }

  
}