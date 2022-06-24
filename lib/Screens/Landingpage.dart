import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Constants/constants.dart';
import 'package:flutter_application_1/Tabs/Homepage.dart';
import 'package:flutter_application_1/authfile/login.dart';
class Landing_page extends StatelessWidget {
 
   final Future<FirebaseApp>_initialization=Firebase.initializeApp();

    Landing_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context , snapshot){
        // if snap hass error
        if(snapshot.hasError) {
          return Scaffold(
          body: Center(
            child: Text("Error :${snapshot.error}" , style: constants.regularheading,),
          ),
        );
        }
        if(snapshot.connectionState==ConnectionState.done){

        return StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context , streamsnapshot){
             if(snapshot.hasError) {
          return Scaffold(
          body: Center(
            child: Text("Error :${streamsnapshot.error}" , style: constants.regularheading,),
          ),
        );
        }
         if(streamsnapshot.connectionState==ConnectionState.active){
          Object? user=streamsnapshot.data;
        
            if(user == null){
              return const LoginPage();
            }else{
              return const Homepage();
            }
        }

          return const Scaffold(
            body: Center(
              child: Text(
                "Please wait for a While ... ", style: constants.regularheading,
              ),
            ),
          );
        });
        }
         return const Scaffold(
          body: Center(
            child: Center(child: Text("intitializing app please wait ..." , style: constants.regularheading,)),
          ),
        );
      },
    );
  }
}