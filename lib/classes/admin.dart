import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalgraduationversion/classes/personel.dart';
import './video.dart';
import './supervisor.dart';
import './psychologist.dart';
class Admin extends Personel{
  Supervisor sup=new Supervisor();
  Video video=new Video();
  Psychologist psychologist=new Psychologist();
  

  // String Open_live_streaming(){}


  List_lastweek_videos()async{
    if(auth()){
       return video.List_lastweek_videos_admin();
    }
  }
  Future<bool> Update_profile(data,ID)async{
    if(auth()){
      await Firestore.instance.collection('admin_information').document(ID).setData(data);
      return true;
    }
    else{
      return false;
    }
    
  }

 Show_video_history()async{
   if(auth()){
     return video.List_videos_admin();
   }
   
  }

  Future<bool> Add_supervisor(Map<String,dynamic>data)async{
    if(auth()){
   return sup.Add_supervisor(data);

    }
    
  }
  Future<bool> Add_psychologist(Map<String,dynamic>data)async{
    if(auth()){
      return psychologist.Add_psychologist(data);
    }
  }

   List_supervisors()async{
     if(auth()){
      return await sup.List_supervisors();
       
     }
     else{
      return false;
    }
  }

  Future<bool> Delete_supervisor(ID)async{
    if(auth()){
      sup.Delete_supervisor(ID);
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> Update_supervisor(data,ID)async{
    if(auth()){
      sup.Update_supervisor(data, ID);
      return true;
    }
    else{
      return false;
    }
    
  }

  
  Future<bool> Delete_psychologist(ID)async{
    if(auth()){
      psychologist.Delete_psychologist(ID);
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> Update_psychologist(data,ID)async{
    if(auth()){
      psychologist.Update_psychologist(data, ID);
      return true;
    }
    else{
      return false;
    }
  }
  List_psychologist()async{
    if(auth()){
       return await psychologist.List_psychologist();
     }
     else{
      return false;
    }
  }
  

}