import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/home/model/hive_constant.dart';
import 'package:note_app/home/model/word_model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitialState());
  static WriteDataCubit get(context) =>
      BlocProvider.of<WriteDataCubit>(context);
  final Box box = Hive.box(HiveConstant.wordBox);
  String text = "";
  bool isArabic = true;
  int colorCode = 0xff9ed2c6;
  final TextEditingController textEditingController = TextEditingController();

  void updateText(String text) {
    this.text = text;
  }

  void updateArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitialState());
  }

  void updateColorCode(int color) {
    colorCode = color;
    emit(WriteDataInitialState());
  }

  void addWord() {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      words.add(WordModel(
          text: textEditingController.text.trim(),
          isArabic: isArabic,
          indexAtDatabase: words.length,
          colorCode: colorCode));
      box.put(HiveConstant.WordList, words);
      emit(WriteDataSuccessState());
    } catch (e) {
      emit(WriteDataFailureState(
          message: 'Error adding word. Please try again'));
    }
  }

  void deleteWord(int indexAtDatabase) {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      // First check if index is valid
      if (indexAtDatabase >= 0 && indexAtDatabase < words.length) {
        words.removeAt(indexAtDatabase);
        // Update indices for all remaining words
        for (int i = indexAtDatabase; i < words.length; i++) {
          words[i] = WordModel(
            text: words[i].text,
            isArabic: words[i].isArabic,
            indexAtDatabase: i, // Set the new index directly
            colorCode: words[i].colorCode,
            arabicSimilarWords: words[i].arabicSimilarWords,
            englishSimilarWords: words[i].englishSimilarWords,
            arabicExamples: words[i].arabicExamples,
            englishExamples: words[i].englishExamples,
          );
        }
        box.put(HiveConstant.WordList, words);
        emit(WriteDataSuccessState());
      } else {
        emit(WriteDataFailureState(message: 'Invalid word index'));
      }
    } catch (e) {
      emit(WriteDataFailureState(
          message: 'Error deleting word. Please try again'));
    }
  }

  List<WordModel> getDataFromHiveBase() =>
      List.from(box.get(HiveConstant.WordList, defaultValue: []))
          .cast<WordModel>();

  void deleteSimilarWord(
      int indexAtDatabase, bool isArabicSimilarWord, int indexAtSimilarWord) {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteSimilarWord(isArabicSimilarWord, indexAtSimilarWord);
      box.put(HiveConstant.WordList, words);
      emit(WriteDataSuccessState());
    } catch (e) {
      emit(WriteDataFailureState(
          message: 'Error deleting similar word. Please try again'));
    }
  }

  void addExample(int indexAtDatabase) {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      if (indexAtDatabase >= 0 && indexAtDatabase < words.length) {
        words[indexAtDatabase] =
            words[indexAtDatabase].addExample(text, isArabic);
        box.put(HiveConstant.WordList, words);
        emit(WriteDataSuccessState());
      } else {
        throw RangeError('Index out of range');
      }
    } catch (e) {
      emit(WriteDataFailureState(message: e.toString()));
    }
  }

  void addSimilarWord(int indexAtDatabase) {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      if (indexAtDatabase >= 0 && indexAtDatabase < words.length) {
        words[indexAtDatabase] =
            words[indexAtDatabase].addSimilarWord(isArabic, text);
        box.put(HiveConstant.WordList, words);
        emit(WriteDataSuccessState());
      } else {
        throw RangeError('Index out of range');
      }
    } catch (e) {
      emit(WriteDataFailureState(message: e.toString()));
    }
  }

  void deleteExample(
      int indexAtDatabase, bool isArabicSimilarWord, int indexAtSimilarWord) {
    emit(WriteDataLoadinglState());
    try {
      List<WordModel> words = getDataFromHiveBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteExample(isArabicSimilarWord, indexAtSimilarWord);
      box.put(HiveConstant.WordList, words);
      emit(WriteDataSuccessState());
    } catch (e) {
      emit(WriteDataFailureState(
          message: 'Error deleting example. Please try again'));
    }
  }
}
