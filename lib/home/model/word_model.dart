import 'dart:math';

import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class WordModel {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isArabic;
  @HiveField(2)
  final int indexAtDatabase;
  @HiveField(3)
  final int colorCode;
  @HiveField(4)
  final List<String>? arabicSimilarWords;
  @HiveField(5)
  final List<String>? englishSimilarWords;
  @HiveField(6)
  final List<String>? arabicExamples;
  @HiveField(7)
  final List<String>? englishExamples;

  WordModel({
    this.arabicExamples,
    this.arabicSimilarWords,
    this.englishSimilarWords,
    this.englishExamples,
    required this.text,
    required this.isArabic,
    required this.indexAtDatabase,
    required this.colorCode,
  });

  WordModel decrementIndexAtDatabase(int indexAtDatabase) {
    return WordModel(
      text: text,
      isArabic: isArabic,
      indexAtDatabase: max(0, indexAtDatabase - 1), // Prevent negative indices
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
    );
  }

  WordModel incrementIndexAtDatabase(int indexAtDatabase) {
    return WordModel(
        text: text,
        isArabic: isArabic,
        indexAtDatabase: indexAtDatabase + 1,
        colorCode: colorCode);
  }

  WordModel deleteExample(isArabicExample, int indexExampleWord) {
    List<String> newExampleWords = initializeNewExampleWord(isArabicExample);
    newExampleWords.removeAt(indexExampleWord);
    return getExampleWordAfterCheckModelist(isArabicExample, newExampleWords);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExampleWords = initializeNewExampleWord(isArabicExample);
    newExampleWords.add(example);
    return getExampleWordAfterCheckModelist(isArabicExample, newExampleWords);
  }

  List<String> initializeNewExampleWord(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExamples ?? []);
    } else {
      return List.from(englishExamples ?? []);
    }
  }

  WordModel addSimilarWord(bool isArabicSimilarWords, String similarWord) {
    List<String> newSimilarWords =
        initializeNewSimilarWord(isArabicSimilarWords);
    newSimilarWords.add(similarWord);
    return getWordAfterCheckModelist(isArabicSimilarWords, newSimilarWords);
  }

  WordModel deleteSimilarWord(
      bool isArabicSimilarWords, int indexAtSimilarWord) {
    List<String> newSimilarWords =
        initializeNewSimilarWord(isArabicSimilarWords);
    newSimilarWords.removeAt(indexAtSimilarWord);
    return getWordAfterCheckModelist(isArabicSimilarWords, newSimilarWords);
  }

  List<String> initializeNewSimilarWord(bool isArabicSimilarWords) {
    if (isArabicSimilarWords) {
      return List.from(arabicSimilarWords ?? []);
    } else {
      return List.from(englishSimilarWords ?? []);
    }
  }

  WordModel getWordAfterCheckModelist(
      bool isArabicSimilarWords, List<String> newSimilarWords) {
    return WordModel(
      text: text,
      isArabic: isArabic,
      indexAtDatabase: indexAtDatabase,
      colorCode: colorCode,
      arabicSimilarWords:
          isArabicSimilarWords ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWords ? newSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
    );
  }

  WordModel getExampleWordAfterCheckModelist(
      bool isArabicExample, List<String> newExampleWords) {
    return WordModel(
      text: text,
      isArabic: isArabic,
      indexAtDatabase: indexAtDatabase,
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      englishExamples: !isArabicExample ? newExampleWords : englishExamples,
      arabicExamples: isArabicExample ? newExampleWords : arabicExamples,
    );
  }
}
