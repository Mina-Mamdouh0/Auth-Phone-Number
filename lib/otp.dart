
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonenumberauth/home.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  const OtpPage({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  bool isLoading =false;
  var controllerOtp=TextEditingController();
  String verificationFailedMassage='';
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?const Center(
        child: CircularProgressIndicator(),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controllerOtp,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: 'Code Sms'
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId,
                  smsCode: controllerOtp.text);

              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential);
              if(auth.currentUser !=null){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
              }
            },
                child: const Text('Verify')),
            const SizedBox(height: 20,),
            Text(verificationFailedMassage),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
