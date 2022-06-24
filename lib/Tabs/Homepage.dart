import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/bottom_tab.dart';
import 'package:flutter_application_1/tab/notification.dart';
class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  
   final  PageController _pageController = PageController();
   int _selectedtab=0;
 
  @override
  void dispose() {
  
   _pageController.dispose();
    super.dispose();
  }


  final User? _user=FirebaseAuth.instance.currentUser;
 Future<void> wait()async{
    // return _user!.uid;
    print("${_user!.uid}");
  }
   @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
                 
                    Expanded(
                    
                    child: PageView(
                      controller:_pageController,
                      // ignore: avoid_types_as_parameter_names
                      onPageChanged: (int){
                              _selectedtab=int;
                             // ignore: avoid_print
                             print('${_selectedtab}');
                      },
                      children: [
                         Container(
                     padding: const EdgeInsets.all(0),
                    child: GestureDetector
                    (
                      onTap: (() {
                        wait();
                      }),
                      child: const Center(child: Text("Homepage"))),
                  ),
                   Container(
                     padding: const EdgeInsets.all(0),
                    child: NotificationPage(),
                  ),
                   Container(
                     padding: const EdgeInsets.all(0),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Center(child: Text("logout"))),
                  ),
                      ],
                    ),
                  ),
                   Bottomtab(selectesTab: _selectedtab, tabPressed: (int) { 
                  
                    setState(() {
                        _pageController.animateToPage(int, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      _selectedtab=int;
                   
                    });
                    },
                   
                   ),
        ],
      ),
    );
  }
}