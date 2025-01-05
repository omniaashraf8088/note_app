import 'package:flutter/material.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/view/widget/add_word_dialog.dart';
import 'package:note_app/home/view/widget/color_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:getFloatingActionButton(context),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ColorWidget(activeColor:WriteDataCubit.get(context).colorCode),
           
        ],
      ),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(backgroundColor:Colors.white,
    child: Icon(Icons.add,color: Colors.black,),
      onPressed: ()=>showDialog(context: context, builder: (context)=>AddWordDialog())
    );
  }
}