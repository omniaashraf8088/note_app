import 'package:flutter/material.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key,
      required this.isArabic,
      this.onPressed,
      required this.color,
      required this.text});
  final String text;
  final Color color;
  final bool isArabic;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: getBoxDecoration(),
      child: Row(
        children: [
          getIsArabicWidget(),
          SizedBox(
            height: 10,
          ),
          Expanded(child: getTextWidget()),
          if (onPressed != null)
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.delete,
                  color: Colors.black12,
                ))
        ],
      ),
    );
  }

  Text getTextWidget() {
    return Text(
      text,
      style: TextStyle(fontSize: 21, color: color, fontWeight: FontWeight.bold),
    );
  }

  CircleAvatar getIsArabicWidget() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.black,
      child: Text(
        isArabic ? "ar" : "en",
        style: TextStyle(color: color),
      ),
    );
  }

  BoxDecoration getBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      );
}
