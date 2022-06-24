import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/custom_btn.dart';
import 'package:flutter_application_1/Constants/custom_input.dart';
import 'package:flutter_application_1/authfile/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // for progress indicator
  // form variables
  String _email="";
  String _password="";
 
  //  focus node
  
  bool _loginloading=false;

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
  Future<String?> _singinaccount()async{
    try{
await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

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
      _loginloading=true;
    });
    String? _createAccountFeedback=await _singinaccount();
    if(_createAccountFeedback !=null){
      alertdilog(_createAccountFeedback);
       setState(() {
      _loginloading=false;
    });
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
             decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  
                ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                        child: const Text(
                          "Hello User ",
                          style: TextStyle(
                              fontSize: 65.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                        child: const Text(
                          "Login Here",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(300.0, 150.0, 0.0, 0.0),
                        child: const Text(
                          ".",
                          style: TextStyle(
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.only(top: 90),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       input(hinttext: 'Email', 
                       
                         Onchanged: (value){
                           _email=value;

                         },  textInputAction: TextInputAction.next, isPasswordField: false,
                      ),
                       input(hinttext: 'password', 
                       
                         Onchanged: (value){
                           _password=value;

                         },  textInputAction: TextInputAction.next, isPasswordField: true,
                      ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: (() {
                            _submit();
                            }),
                            child: btn(
                              isLoading: _loginloading,
                              text: "Login",
                              outlinebtn: false
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Singup()));
                              },
                              child: btn(
                                text: "Create New Account",
                                outlinebtn: true, isLoading: false,
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
      ),
    );
  }
}
