import 'package:flutter/material.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/home/view/widget/add_word_dialog.dart';
import 'package:note_app/home/view/widget/filter_dialog_button.dart';
import 'package:note_app/home/view/widget/language_filter.dart';
import 'package:note_app/home/view/widget/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFloatingActionButton(context),
      appBar: AppBar(
        title: Text('Note App',style:TextStyle(fontWeight:FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageFilterCustomWidget(),
                Spacer(),
                FilterDialogButton()
              ],
            ),
            SizedBox(height: 10,),
            Expanded(child: WordsWidget()),
          ],
        ),
      ),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          size:30,
          Icons.add,
          color:AppColors.baseColor3,
        ),
        onPressed: () => showDialog(
            context: context, builder: (context) => AddWordDialog()));
  }
}
