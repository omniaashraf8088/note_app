import 'package:flutter/material.dart';

class DoneButton
 extends StatelessWidget {
  const DoneButton
  ({super.key,required this.colorCode,required this.onTap
  });
  final int colorCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.centerRight,
      child: InkWell(
        onTap:onTap,
        child: Container(
          height: 40,width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            
          ),
          child: Center(child: Text("Done",style: TextStyle(color:Color(colorCode),fontWeight: FontWeight.bold),))
        ),
      ),
    );
  }
}