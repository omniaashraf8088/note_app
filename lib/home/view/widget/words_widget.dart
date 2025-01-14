import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/model/word_model.dart';
import 'package:note_app/home/view/widget/exception_widget.dart';
import 'package:note_app/home/view/widget/loading_widget.dart';
import 'package:note_app/home/view/widget/word_item_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataSucceState) {
          if (state.words.isEmpty) {
            return getEmptyWordsWidget();
          }
          return getWordsWidget(state.words);
        } else if (state is ReadDataFaildState) {
          return getFailedWidget(state.message);
        } else if (state is ReadDataLoadingState) {
          final x = state;
          return getLoadingWidget();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget getWordsWidget(List<WordModel> words) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: words.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return WordItemWidget(wordModel: words[index]);
        });
  }

  Widget getEmptyWordsWidget() {
    return ExceptionWidget(
      iconData: Icons.import_contacts,
      message: "  empty word list ",
    );
  }

  Widget getFailedWidget(String message) {
    return ExceptionWidget(
        iconData: Icons.error, message: "  empty word list ");
  }
}

Widget getLoadingWidget() {
  return LoadingWidget();
}
