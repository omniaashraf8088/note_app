import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';

class LanguageFilterCustomWidget extends StatelessWidget {
  const LanguageFilterCustomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Text(
          mapLanguageFilterEnumtoString(ReadDataCubit.get(context).languageFilter),
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }


  String mapLanguageFilterEnumtoString(LanguageFilter languageFilter){
    if(languageFilter == LanguageFilter.allWords){
      return 'All Words';
    }else if (languageFilter == LanguageFilter.arabicOnly) {
      return 'arabicOnly';
    }
    if (languageFilter == LanguageFilter.englishOnly) {
      return 'englishOnly';
    }
    return '';
  }
}
