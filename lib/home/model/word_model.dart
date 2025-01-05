class WordModel {
  final String text;
  final bool isArabic;
  final int indexAtDatabase;
  final int colorCode;
  final List<String>? arabicSimilarWords;
  final List<String>? englishSimilarWords;
  final List<String>? arabicExamples;
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
        indexAtDatabase: indexAtDatabase - 1,
        colorCode: colorCode);
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

  WordModel addExample(String example, isArabicExample) {
    List<String> newExampleWords = initializeNewExampleWord(isArabicExample);
    return getExampleWordAfterCheckModelist(isArabicExample, newExampleWords);
  }

  List<String> initializeNewExampleWord(
    isArabicExample,
  ) {
    if (isArabicExample) {
      arabicExamples;
    } else {
      englishExamples;
    }
    return initializeNewExampleWord(isArabicExample);
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
