import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Video{
  Timestamp date_time;
  String location;
  String status;
  String url;

  Video(){}
  Timestamp GetDateTime(){
    return this.date_time;
  }
  String GetLocation(){
    return this.location;
  }
  SetStatus(String status){
    this.status=status;
  }
  String GetStatus(){
    return this.status;
  }
  String GetUrl(){
    return this.url;
  }
  
  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }
  List_lastweek_videos_admin()async{
    if(auth()){
      DateTime pastweek = DateTime.now().subtract(Duration(days: 7));
    Stream<QuerySnapshot> bullying_videos = await Firestore.instance
                  .collection('bullying_videoss')
                  .where('date_time', isGreaterThanOrEqualTo: pastweek)
                  .snapshots();

                  return bullying_videos;
    }
  }

  List_videos_admin()async{
    if(auth()){
     Stream<QuerySnapshot> bullying_videos = await Firestore.instance.collection('bullying_videoss').snapshots();
     return bullying_videos;
   }
  }

  List_lastweek_videos_supervisor(String supervision_location)async{
    if(auth()){
       DateTime pastweek = DateTime.now().subtract(Duration(days: 7));
    Stream<QuerySnapshot> bullying_videos = await Firestore.instance
                .collection('bullying_videoss')
                .where('location', isEqualTo: supervision_location)
                .where('date_time', isGreaterThanOrEqualTo: pastweek)
                .snapshots();
    
    return bullying_videos;
    }
  }

  List_videos_supervisor(String supervision_location)async{
    if(auth()){
    Stream<QuerySnapshot> bullying_videos = await Firestore.instance
                .collection('bullying_videoss')
                .where('location', isEqualTo: supervision_location)
                .snapshots();
    
    return bullying_videos;
    }
  }

  Update_status(status,ID)async{
if(auth()){
  DocumentSnapshot camera= await Get_notification_data(ID);
   await Firestore.instance.collection('bullying_on_camera').document(ID).setData({
      'camera_number': camera.data['camera_number'],
      'date_time':camera.data['date_time'],
      'status':status,
    });
    String floor_number="Floor ${camera.data['camera_number']}";
    print("........................................+$floor_number");
   QuerySnapshot videos= await Firestore.instance.collection('bullying_videoss').where('date_time',isEqualTo:camera.data['date_time'])
    .where('location',isEqualTo:floor_number).getDocuments().then((v){
      if(v!=null){
        print("........not equal null ya shosho");
        v.documents.forEach((value){
              print(value.data);
               Update_status_video(value,status);
            });

      }
    });
}
    
  }

  Get_notification_data(String doc_id)async{
    if(auth()){
       DocumentSnapshot camera= await Firestore.instance.collection('bullying_on_camera').document(doc_id).get();
         return camera;
    }
  }

  Update_status_video(DocumentSnapshot video,String status)async{
    if(auth()){
      await Firestore.instance.collection('bullying_videoss').document(video.documentID).setData({
      'date_time':video.data['date_time'],
      'location':video.data['location'],
      'status':'Solved',
      'video_link':video.data['video_link']
    });
    }
    
  }

  Future<String> Get_notification_status(String doc_id)async{
    if(auth()){
       DocumentSnapshot camera= await Firestore.instance.collection('bullying_on_camera').document(doc_id).get();
         return camera.data['status'];
    }
  }


}