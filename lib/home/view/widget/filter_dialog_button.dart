import 'package:flutter/material.dart';
import 'package:note_app/home/view/widget/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       showDialog(context: context, builder:  (context) => FilterDialog());
      },
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.menu_open_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
