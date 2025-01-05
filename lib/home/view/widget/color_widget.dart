import 'package:flutter/material.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColor});
  final int activeColor;
  final List<int> codeColorsList = const [
    0xffe3cbb5,
    0xffc8a27e,
    0xffe3cbb5,
    0xffbfa58a,
    0xffd9c2a6,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return getColorCode(index, context);
        },
      ),
    );
  }

  Widget getColorCode(int index, BuildContext context) {
    return InkWell(
      onTap: WriteDataCubit.get(context).updateColorCode(codeColorsList[index]),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.circle,
            color: Color(codeColorsList[index])),
        child: activeColor == codeColorsList[index]
            ? Center(
                child: Icon(
                Icons.done,
                color: Colors.white,
              ))
            : Container(
                width: 50,
                height: 50,
                color: Colors.amber,
                child: Text('hello , code color list error'),
              ),
      ),
    );
  }
}
