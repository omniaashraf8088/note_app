import 'package:flutter/material.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColor});
  final int activeColor;
  final List<int> codeColorsList = const [
    0xff9ed2c6, // Soft Teal
    0xFF4682B4, // Coral Pink
    0xffd9c2a6e, // Deep Lavender
    0xffd9c2a6, // Bright Yellow
    0xFFB0C4DE, // Ocean Blue
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        itemCount: codeColorsList.length,
        itemBuilder: (context, index) => getColorCode(index, context),
      ),
    );
  }

  Widget getColorCode(int index, BuildContext context) {
    return InkWell(
      onTap: () =>
          WriteDataCubit.get(context).updateColorCode(codeColorsList[index]),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.circle,
            color: Color(codeColorsList[index])),
        child: activeColor == codeColorsList[index]
            ? const Center(
                child: Icon(
                Icons.done,
                color: Colors.white,
              ))
            : null, // Remove debug container, just show empty colored circle
      ),
    );
  }
}
