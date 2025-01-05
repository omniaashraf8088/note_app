import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/home/model/hive_constant.dart';
import 'package:note_app/home/model/word_model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitialState());
  static get(context) => BlocProvider.of<WriteDataCubit>(context);
  final Box box = Hive.box(HiveConstant.wordBox);
  String text = "";
  bool isArabic = true;
  int colorCode = 0xff4A4788;

  void updateText(String text) {
    this.text = text;
  }

  void updateArabic(String text) {
    this.text = text;
  }

  void updateColorCode(String text) {
    this.text = text;
    emit(WriteDataInitialState());
  }

  void addWord() {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words.add(WordModel(
          text: text,
          isArabic: isArabic,
          indexAtDatabase: words.length,
          colorCode: colorCode));
      box.put(HiveConstant.WordList, words);
    }, 'we have error when add word,please trying agine');
  }

  void deleteWord(int indexAtDatabase) {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words.removeAt(indexAtDatabase);
      for (int i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDatabase(indexAtDatabase);
      }
      box.put(HiveConstant.WordList, words);
    }, 'we have error when delete word,please trying agine');
  }

  List<WordModel> getDataFromHiveBase() =>
      List.from(box.get(HiveConstant.WordList, defaultValue: []))
          .cast<WordModel>();

  void tryAndCatchBack(VoidCallback methdToExecute,String message) {
    emit(WriteDataLoadinglState());
    try {
      emit(WriteDataLoadinglState());
      methdToExecute.call;
      emit(WriteDataSuccessState());
    } catch (e) {
      emit(WriteDataFailureState(message: message));
    }
  }

  void deleteSimilarWord(
      int indexAtDatabase, bool isArabicSimilarWord, int indexAtSimilarWord) {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteSimilarWord(isArabicSimilarWord, indexAtSimilarWord);

      box.put(HiveConstant.WordList, words);
    }, 'we have error when deleteSimilarWord word,please trying agine');
  }

  void addExample(int indexAtDatabase) {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addExample(text, isArabic);
      box.put(HiveConstant.WordList, words);
    }, 'we have error when add word,please trying agine');
  }

  void addSimilarWord(int indexAtDatabase) {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(isArabic, text);
      box.put(HiveConstant.WordList, words);
    }, 'we have error when add Similar Word ,please trying agine');
  }

  void deleteExample(
      int indexAtDatabase, bool isArabicSimilarWord, int indexAtSimilarWord) {
    tryAndCatchBack(() {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].deleteExample(isArabic, indexAtDatabase);
      box.put(HiveConstant.WordList, words);
    }, 'we have error when delete Example ,please trying agine');
  }
}
