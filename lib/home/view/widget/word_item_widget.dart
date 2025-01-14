import 'package:flutter/material.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/model/word_model.dart';
import 'package:note_app/home/view/screens/details_screen.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(wordModel: wordModel),
            ),
          ).then((value) async {
            Future.delayed(Duration(seconds: 1)).then((value) {
              ReadDataCubit.get(context).getWords();
            });
          });
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: getWordItemDecoration(),
          child: Center(
            child: Text(
              wordModel.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  BoxDecoration getWordItemDecoration() {
    return BoxDecoration(
      color: Color(wordModel.colorCode),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
