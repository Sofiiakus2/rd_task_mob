
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   static Future<bool> saveUser({
//     required BuildContext context,
//     required String name,
//     required String phoneNumber,
//     //required String
// })async{
//   try{
//
//   }
// }

  // Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async{
  //   PhoneVerificationCompleted verificationCompleted =
  //   (PhoneAuthCredential phoneAuthCredential) async{
  //     showSnackBar(context, "Verification completed");
  //   };
  //   PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception){
  //     showSnackBar(context, exception.toString());
  //   };
  //   PhoneCodeSent codeSent =
  //       (String verificationID, [int? forceResendingtoken]) {
  //         showSnackBar(context, "Verification Code sent on your phone");
  //       } as PhoneCodeSent;
  //   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationID){
  //     showSnackBar(context, "Time out ");
  //   };
  //   try{
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //         verificationCompleted: verificationCompleted,
  //         verificationFailed: verificationFailed,
  //         codeSent: codeSent,
  //         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   }catch(e){
  //     showSnackBar(context, e.toString());
  //   }
  // }
  //
  // void showSnackBar(BuildContext context, String text){
  //   final snackBar = SnackBar(content: Text(text));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    //print('Token: $fCMToken');
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}