import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/Constants/custom_btn.dart';
import 'package:flutter_application_1/Constants/custom_input.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({ Key? key }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
   String _email="";

  String _name="";
  //  focus node
  
  bool _registerloading=false;


  Future<void> alertdilog(String error)async{

    return showDialog(context: context,
    barrierDismissible: false,
     builder: (context){
       return AlertDialog(
              title: const Text("error"),
              content: Container(
                 padding: const EdgeInsets.all(0),
                 child:Text(error)),
              actions: [
                TextButton(
                   
                  onPressed: () { 
                    Navigator.pop(context);
                   },
                  child: const Text("close Dilog"))
              ],
       );
     });
  }
  Future<String?> _createaccount()async{
    try{
// await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
await FirebaseFirestore.instance.collection('Not').add({
  'email':_email,
  "name":_name
});
return null;
    }
   
    catch(e){
      return(e.toString());

    }
  }
  void _submit() async{
    setState(() {
      _registerloading=true;
    });
    String? _createAccountFeedback=await _createaccount();
    if(_createAccountFeedback !=null){
      alertdilog(_createAccountFeedback);
       setState(() {
      _registerloading=false;
    });
    }else{
      Navigator.pop(context);
    }
   
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Container(
             padding: const EdgeInsets.all(0),
                 margin: const EdgeInsets.only(top:90),
                 width: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    input(
                       
                       hinttext: 'Name',
                       
                       
                         Onchanged: (value){
                           _name=value;

                         }, textInputAction: TextInputAction.next,
                          isPasswordField: false,
                         
                        ),

                         input(
                       
                       hinttext: 'Email',
                       
                       
                         Onchanged: (value){
                           _email=value;

                         }, textInputAction: TextInputAction.next, isPasswordField: false,
                         
                        ),

                        GestureDetector(
                          onTap: (() {
                            _submit();
                          }),
                          child: btn(text: "Submit", outlinebtn: true,  isLoading: _registerloading))
              ],
            ),
          ),
        ) ),
    );
  }
}