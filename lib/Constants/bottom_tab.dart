import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Bottomtab extends StatefulWidget {
    final int selectesTab;
    final Function(int) tabPressed;
  // ignore: use_key_in_widget_constructors
  const Bottomtab({ required this.selectesTab, required this.tabPressed});

  @override
  State<Bottomtab> createState() => _BottomtabState();
}

class _BottomtabState extends State<Bottomtab> {
 int _selectedTab=0;

  @override
  Widget build(BuildContext context) {
    _selectedTab=widget.selectesTab ;
    return Container(
      decoration:  BoxDecoration(
        color:Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 30.0
          )
        ]
      ),
      padding: const EdgeInsets.only(left: 20 , right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          GestureDetector(
           onTap: () {
               widget.tabPressed(0);
             },
            child: Bottombtn(
              imagePath: 'assets/images/home.png',
               selected: _selectedTab==0?true:false, 
              
               
              
            ),
          ),
           GestureDetector(
             onTap: () {
               widget.tabPressed(1);
             },
             child: Bottombtn(imagePath: 'assets/images/plus.png', 
             selected: _selectedTab==1?true:false,
                    
             
             
             
             ),
           ),
            GestureDetector(
              onTap: () {
               widget.tabPressed(2);
             },
              child: Bottombtn(
                imagePath: 'assets/images/logout.png', 
                selected: _selectedTab==2?true:false,
              
                ),
            ),
        ],
      ),
    );
  }
}

class Bottombtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  // final Function onPressed;
  // ignore: use_key_in_widget_constructors
  const Bottombtn({  required this.imagePath, required this.selected }) ;

  @override
  Widget build(BuildContext context) {
    bool _selected=selected ;
    return GestureDetector(
      
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).colorScheme.secondary:Colors.transparent,
            width: 2.0
            )
          )
        ),
        padding:  const EdgeInsets.symmetric(vertical:20.0 ,horizontal:20.0 ),
        child: Image(image:
         AssetImage
        (imagePath),
        width: 32.0,height: 32.0,
        color: _selected ? Theme.of(context).colorScheme.secondary:Colors.black,
        ),
    
      ),
    );
  }
}