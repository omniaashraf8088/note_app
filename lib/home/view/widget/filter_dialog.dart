import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                getLabelText("Language"),
                SizedBox(
                  height: 10,
                ),
                getFilterField(labels: [
                  "Arabic",
                  "English",
                  "All"
                ], onTap: [
                  () => ReadDataCubit.get(context)
                      .updateLanguageFilter(LanguageFilter.arabicOnly),
                  () => ReadDataCubit.get(context)
                      .updateLanguageFilter(LanguageFilter.englishOnly),
                  () => ReadDataCubit.get(context)
                      .updateLanguageFilter(LanguageFilter.allWords),
                ], conditionIsActivtion: [
                  ReadDataCubit.get(context).languageFilter ==
                      LanguageFilter.arabicOnly,
                  ReadDataCubit.get(context).languageFilter ==
                      LanguageFilter.englishOnly,
                  ReadDataCubit.get(context).languageFilter ==
                      LanguageFilter.allWords
                ]),
                SizedBox(
                  height: 15,
                ),
                getLabelText("Sorted By"),
                SizedBox(
                  height: 10,
                ),
                getSortedByFilter(context),
                SizedBox(
                  height: 15,
                ),
                getLabelText("Sorted Type"),
                SizedBox(
                  height: 10,
                ),
                getSortedTypeFilter(context),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getSortedByFilter(BuildContext context) {
    return getFilterField(labels: [
      "Time",
      "Word Length"
    ], onTap: [
      () => ReadDataCubit.get(context).updateSortedBy(SortedBy.time),
      () => ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength),
    ], conditionIsActivtion: [
      ReadDataCubit.get(context).sortedBy == SortedBy.time,
      ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
    ]);
  }
}

Widget getSortedTypeFilter(BuildContext context) {
  return getFilterField(labels: [
    "Descending",
    "Ascending"
  ], onTap: [
    () => ReadDataCubit.get(context).updateSortingType(SortingType.Descending),
    () => ReadDataCubit.get(context).updateSortingType(SortingType.Ascending),
  ], conditionIsActivtion: [
    ReadDataCubit.get(context).sortingType == SortingType.Descending,
    ReadDataCubit.get(context).sortingType == SortingType.Ascending,
  ]);
}

Widget getFilterField({
  required List<String> labels,
  required List<VoidCallback> onTap,
  required List<bool> conditionIsActivtion,
}) {
  return Row(
    children: [
      for (int i = 0; i < labels.length; i++)
        InkWell(
          onTap: onTap[i],
          child: Container(
            height: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: conditionIsActivtion[i] ? Colors.white : Colors.black,
            ),
            child: Center(
              child: Text(labels[i],
                  style: TextStyle(
                    color:
                        conditionIsActivtion[i] ? Colors.black : Colors.white,
                  )),
            ),
          ),
        )
    ],
  );
}

Widget getLabelText(final String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
  );
}
