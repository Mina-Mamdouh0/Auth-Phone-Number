
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonenumberauth/otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading =false;
  var controllerPhoneNumber=TextEditingController();
  String verificationFailedMassage='';
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
              controller: controllerPhoneNumber,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone Number'
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+2001210963121',
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {
                  setState(() {
                    verificationFailedMassage=e.code;
                  });
                },
                codeSent: (String verificationId, int? resendToken) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpPage(verificationId: verificationId)));
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            },
                child: const Text('Send')),

      const SizedBox(height: 20,),
      Text(verificationFailedMassage),
       const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
