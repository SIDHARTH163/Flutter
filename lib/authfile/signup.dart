

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/custom_btn.dart';
import 'package:flutter_application_1/Constants/custom_input.dart';
import 'package:flutter_application_1/authfile/login.dart';
class Singup extends StatefulWidget {
  const Singup({ Key? key }) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  // for progress indicator
  // form variables
  String _email="";
  String _password="";
  String _name="";
  //  focus node
  
  bool _registerloading=false;

  // alert dilog for displaying error
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
final result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
result.user?.updateDisplayName(_name);
await FirebaseFirestore.instance.collection('Profiles').doc(result.user?.uid).set({
  'email':_email,
  "name":_name,
  'userid':result.user!.uid,
});

return null;
    }
    on FirebaseAuthException catch(e){
      if(e.code=='weak password'){
        return("password is weak");
      }else if(e.code=='email-already-in-use'){
        return("useDifrent email");
      }
      return e.message;
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
        child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
          child: Column(
             children: [
               SizedBox(
                 width: double.infinity,
                 child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                    child: const Text("Hello User " ,style: TextStyle(
                      fontSize: 65.0 , fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                    child: const Text("Signup Here" ,style: TextStyle(
                       color: Colors.green,
                      fontSize: 55.0 , fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(345.0, 150.0, 0.0, 0.0),
                    child: const Text("." ,style: TextStyle(
                      fontSize: 55.0 , fontWeight: FontWeight.bold,  color:Colors.blue
                    ),),
                  ),
      
      
                  
                ],
              ),
               ),
               // ignore: sized_box_for_whitespace
               Container(
                 padding: const EdgeInsets.all(0),
                 margin: const EdgeInsets.only(top:90),
                 width: double.infinity,
                 child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                   children:[
                     input(
                       
                       hinttext: 'Name',
                       
                       
                         Onchanged: (value){
                           _name=value;

                         }, textInputAction: TextInputAction.next, isPasswordField: false,
                         
                        ),
                      input(hinttext: 'Email', 
                       
                         Onchanged: (value){
                           _email=value;

                         },  textInputAction: TextInputAction.next, isPasswordField: false,
                      ),
                      input(hinttext: 'Password', 
                      
                         Onchanged: (value){
                           _password=value;

                         },
                          textInputAction: TextInputAction.next, isPasswordField: true,
                      ),
                    Container(
                      
                       margin: const EdgeInsets.only(top: 10),
                      
                       child: GestureDetector(
                         onTap: (){
                          _submit();
                        // setState(() {
                        //   _registerloading=true;
                        // });
                         },
                         child: btn(
                           text: "Create Your Account",  outlinebtn:false, isLoading: _registerloading,
                         ),
                       ),
                     ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(top:24.0),
                          child:GestureDetector(
                             onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>const LoginPage()));
                            },
                            child: btn(
                             text: "Allready have an account",  outlinebtn:true, isLoading: false,
                                           ),
                          ),
                        ),
                      ),
      
                 ]),
               ),
             ],
           ),
        ),
      ),
      );
    
  }
}