import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_ip/get_ip.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Personel {
  String email;
  String password;
  String name;
  int phone_number;
  String mobile_token;

  personel(String E_mail, String pass, String name, int phone) {
    this.email = E_mail;
    this.password = pass;
    this.name = name;
    this.phone_number = phone;
  }

  Personel() {}

  void SetEmail(String email) {
    this.email = email;
  }

  String GetEmail() {
    return this.email;
  }

  void SetPassword(String password) {
    this.password = password;
  }

  String GetPassword() {
    return this.password;
  }

  void SetName(String name) {
    this.name = name;
  }

  String GetName() {
    return this.name;
  }

  void SetPhoneNumber(int phonenumber) {
    this.phone_number = phonenumber;
  }

  int GetPhoneNumber() {
    return this.phone_number;
  }

  void SetMobileToken(String token) {
    this.mobile_token = token;
  }

  String GetMobileToken() {
    return this.mobile_token;
  }

  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }

  Future<String> is_admin(String id) async {
    String ipAddress = await GetIp.ipAddress;
    DocumentSnapshot admin = await Firestore.instance
        .collection('admin_information')
        .document(id)
        .get();
    if (admin == null || !admin.exists) {
      return "false";
    } else if (admin.data['passward'] != ipAddress) {
      print("nooooooooooooooooooo ip address of the phone not equal password");
      return "false";
    } else {
      return "true";
    }
  }

  Future<String> is_supervisor(String id) async {
    String ipAddress = await GetIp.ipAddress;
    final supervisor =
        await Firestore.instance.collection('Supervisors').document(id).get();
    if (supervisor == null || !supervisor.exists) {
      return "false";
    } else if (supervisor.data['IP_Address'] != ipAddress) {
      print("nooooooooooooooooooo ip address of the phone not equal password");
      return "false";
    } else {
      return "true";
    }
  }

  Future<String> is_pychologist(String id) async {
    String ipAddress = await GetIp.ipAddress;
    final pychologist = await Firestore.instance
        .collection('pychologist_information')
        .document(id)
        .get();
    if (pychologist == null || !pychologist.exists) {
      return "false";
    } else if (pychologist.data['passward'] != ipAddress) {
      print("nooooooooooooooooooo ip address of the phone not equal password");
      return "false";
    } else {
      return "true";
    }
  }

  Future<String> Login(username, password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      String user = result.user.uid;
      String admin = await is_admin(user);
      String supervisor = await is_supervisor(user);
      String pychologist = await is_pychologist(user);
      print(
          "admin = $admin and supervisor = $supervisor and psychologist = $pychologist");
      if (admin == "true" && supervisor == "false" && pychologist == "false") {
        return 'admin';
      } else if (supervisor == "true" &&
          admin == "false" &&
          pychologist == "false") {
        return 'supervisor';
      } else if (pychologist == "true" &&
          supervisor == "false" &&
          admin == "false") {
        return 'psychologist';
      } else {
        return 'enemy';
      }
    } catch (error) {
      print(error);
      print("_username=$username");
    }
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? user.uid : null;
  }

  save_token(String supervision_location) {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    getCurrentUser().then((data) {
        String user_id = data;
        _firebaseMessaging.getToken().then((token) async {
      if (supervision_location == "admin") {
        Firestore.instance
            .collection('floors_tokens')
            .document(user_id)
            .setData({'token': token ,'position':'admin'});
      } else if (supervision_location == "Floor 1") {
          Firestore.instance
            .collection('floors_tokens')
            .document(user_id)
            .setData({'token': token ,'position':'floor1' });
        } else if (supervision_location == "Floor 2") {
          Firestore.instance
            .collection('floors_tokens')
            .document(user_id)
            .setData({'token': token ,'position':'floor2' });
        } else if (supervision_location == "Floor 3") {
          Firestore.instance
            .collection('floors_tokens')
            .document(user_id)
            .setData({'token': token ,'position':'floor3' });
        }
        else if(supervision_location=="psychologist"){
          Firestore.instance
            .collection('floors_tokens')
            .document(user_id)
            .setData({'token': token ,'position':'psychologist'});
        }
      
    });

      
    });
    
  }

View_Profile(String position) async{
  String user_id = await getCurrentUser();
  if(position=='admin'){
    return Firestore.instance
                  .collection('admin_information')
                  .document(user_id)
                  .snapshots();
  }
  else if(position=='supervisor'){
    return Firestore.instance
                                    .collection('Supervisors')
                                    .document(user_id)
                                    .snapshots();
  }
  else if(position=='psychologist'){
    return Firestore.instance
                  .collection('pychologist_information')
                  .document(user_id)
                  .snapshots();
  }
    
  }
  Future<bool> Send_Us_Email(data) async {
    if (auth()) {
      Firestore.instance.collection('emails').add(data);
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> Logout() async{
    if(auth()){
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
              await _firebaseAuth.signOut();
              return true;
    } 
    else{
      return false;
    }
     }
  
  
}
