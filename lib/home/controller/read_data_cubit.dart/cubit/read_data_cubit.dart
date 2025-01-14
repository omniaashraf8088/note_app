import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/home/model/hive_constant.dart';
import 'package:note_app/home/model/word_model.dart';
part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  static ReadDataCubit get(context) => BlocProvider.of(context);
  ReadDataCubit() : super(ReadDataInitiState());
  final Box box = Hive.box(HiveConstant.wordBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.Descending;

  void updateLanguageFilter(LanguageFilter LanguageFilter) {
    this.languageFilter = LanguageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

  void getWords() {
    try {
      emit(ReadDataLoadingState());
      List<WordModel> wordReturn =
          List.from(box.get(HiveConstant.WordList, defaultValue: [])).cast();
      RemoveUnWantedWord(wordReturn);
      applySortedBy(wordReturn);
      //لو شال الكلمه الغير مطلوبه وبعدين رتبهم المفروض لو ص نكمل لخطوه النهائيه
      emit(ReadDataSucceState(words: wordReturn));
    } catch (error) {
      emit(ReadDataFaildState(
          message: "we have a prblem , please trying later!"));
      throw Exception();
    }
  }

//كده الي هيجي بعد المسح هيقعد مكان العنصر الي اتمسح وياخد مكانو فبتالي مكان الحاجه الي اتمسحت
  void RemoveUnWantedWord(List<WordModel> wordReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordReturn[i].isArabic == true)) {
        wordReturn.removeAt(i);
        i--;
      }
    }
  }

  void applySortedBy(List<WordModel> returnWord) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.Descending) {
        return;
      } else {
        return reverse(returnWord);
      }
    } else {
      returnWord.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingType == SortingType.Descending) {
        return;
      } else {
        return reverse(returnWord);
      }
    }
  }

  void reverse(List<WordModel> returnWord) {
    for (var i = 0; i < returnWord.length / 2; i++) {
      WordModel temp = returnWord[i];
      returnWord[i] = returnWord[returnWord.length - 1 - i];
      returnWord[returnWord.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords,
}

enum SortingType { Descending, Ascending }

enum SortedBy {
  wordLength,
  time,
}
