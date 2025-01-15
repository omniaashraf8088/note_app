import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/model/word_model.dart';
import 'package:note_app/home/view/widget/exception_widget.dart';
import 'package:note_app/home/view/widget/loading_widget.dart';
import 'package:note_app/home/view/widget/update_word_button.dart';
import 'package:note_app/home/view/widget/update_word_dialog.dart';
import 'package:note_app/home/view/widget/word_info_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late WordModel _wordModel;

  @override
  void initState() {
    _wordModel = widget.wordModel;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if (state is ReadDataSucceState) {
            final int wordIndex = state.words.indexWhere((element) =>
                element.indexAtDatabase == _wordModel.indexAtDatabase);

            if (wordIndex == -1) {
              return ExceptionWidget(
                  iconData: Icons.error, message: "Word not found");
            }

            _wordModel = state.words[wordIndex];
            return getSuccessBody(context);
          }
          if (state is ReadDataFaildState) {
            return ExceptionWidget(
                iconData: Icons.error, message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  ListView getSuccessBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      children: [
        getLabelText("Task To Do"),
        SizedBox(
          height: 5,
        ),
        WordInfoWidget(
            isArabic: _wordModel.isArabic,
            text: _wordModel.text,
            color: Color(
              _wordModel.colorCode,
            )),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            getLabelText("Task"),
            Spacer(),
            UpdateWordButton(
              onTap: () => showDialog(
                context: context,
                builder: (context) => UpdateWordDialog(
                  indexOfDataBase: _wordModel.indexAtDatabase,
                  cololrCode: _wordModel.colorCode,
                  isExample: false,
                ),
              ),
              color: Color(_wordModel.colorCode),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (_wordModel.arabicSimilarWords != null)
          for (int i = 0; i < _wordModel.arabicSimilarWords!.length; i++)
            WordInfoWidget(
                onPressed: () => deleteArabicSimilarWord(i),
                isArabic: true,
                color: Color(_wordModel.colorCode),
                text: _wordModel.arabicSimilarWords![i]),
        if (_wordModel.englishSimilarWords != null)
          for (int i = 0; i < _wordModel.englishSimilarWords!.length; i++)
            WordInfoWidget(
                onPressed: () => deleteEnglishSimilarWord(i),
                isArabic: false,
                color: Color(_wordModel.colorCode),
                text: _wordModel.englishSimilarWords![i]),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            getLabelText("Sub Task"),
            Spacer(),
            UpdateWordButton(
              onTap: () => showDialog(
                context: context,
                builder: (context) => UpdateWordDialog(
                  indexOfDataBase: _wordModel.indexAtDatabase,
                  cololrCode: _wordModel.colorCode,
                  isExample: true,
                ),
              ),
              color: Color(_wordModel.colorCode),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (_wordModel.arabicExamples != null)
          for (int i = 0; i < _wordModel.arabicExamples!.length; i++)
            WordInfoWidget(
                onPressed: () => deleteArabicExample(i),
                isArabic: true,
                color: Color(_wordModel.colorCode),
                text: _wordModel.arabicExamples![i]),
        if (_wordModel.englishExamples != null)
          for (int i = 0; i < _wordModel.englishExamples!.length; i++)
            WordInfoWidget(
                onPressed: () => deleteEnglishExample(i),
                isArabic: false,
                color: Color(_wordModel.colorCode),
                text: _wordModel.englishExamples![i]),
      ],
    );
  }

  void deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      indexAtDatabase: _wordModel.indexAtDatabase,
      isArabicSimilarWord: true,
      indexAtSimilarWord: index,
    );

    ReadDataCubit.get(context).getWords();
  }

  void deleteEnglishSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      indexAtDatabase: _wordModel.indexAtDatabase,
      isArabicSimilarWord: false,
      indexAtSimilarWord: index,
    );
    ReadDataCubit.get(context).getWords();
  }

  void deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      indexAtDatabase: _wordModel.indexAtDatabase,
      indexExampleWord: index,
      isArabicExample: true,
    );

    ReadDataCubit.get(context).getWords();
  }

  void deleteEnglishExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      indexAtDatabase: _wordModel.indexAtDatabase,
      indexExampleWord: index,
      isArabicExample: false,
    );
    ReadDataCubit.get(context).getWords();
  }

  Widget getLabelText(String label) => Text(
        label,
        style: TextStyle(
            color: Color(_wordModel.colorCode),
            fontSize: 21,
            fontWeight: FontWeight.bold),
      );

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Color(_wordModel.colorCode),
      title: Text(
        "Task Details",
        style: TextStyle(
            color: Color(_wordModel.colorCode), fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () => deleteWord(context),
            icon: Icon(Icons.delete, color: Color(_wordModel.colorCode)))
      ],
    );
  }

  void deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(_wordModel.indexAtDatabase);
    Navigator.pop(context);
  }
}
