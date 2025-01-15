import 'package:flutter/material.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key,
  required this.controller,
  required this.formKey, required this.lable});
  final String lable;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: TextFormField(
          autocorrect: true,
          controller: controller,
          validator: (value) {
            return getValidator(value, WriteDataCubit.get(context).isArabic)
                ?.call(value);
          },
          onChanged: (value) =>
              WriteDataCubit.get(context).updateArabic(isArabicText(value)),
          minLines: 1,
          maxLines: 2,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: getInputDecoration(),
        ));
  }

  String? Function(String?)? getValidator(String? value, bool isArabic) {
    return (String? value) {
      // First check for null or empty
      if (value == null || value.trim().isEmpty) {
        return 'This field cannot be empty';
      }

      // Inner function to check character types
      charType getCharType(int asciiCode) {
        if ((asciiCode >= 65 && asciiCode <= 90) ||
            (asciiCode >= 97 && asciiCode <= 122)) {
          return charType.english;
        } else if (asciiCode >= 1569 && asciiCode <= 1610) {
          // Removed duplicate English range
          return charType.arabic;
        } else if (asciiCode == 32) {
          return charType.space;
        }
        return charType.notValid;
      }

      // Validate each character
      for (var i = 0; i < value.length; i++) {
        charType characterType = getCharType(value.codeUnitAt(i));
        if (characterType == charType.notValid) {
          return "Character at position ${i + 1} is not valid";
        } else if (isArabic && characterType == charType.english) {
          return "Character at position ${i + 1} should be Arabic";
        } else if (!isArabic && characterType == charType.arabic) {
          return "Character at position ${i + 1} should be English";
        }
      }
      return null; // Return null if validation passes
    };
  }

  bool isArabicText(String text) {
    for (var i = 0; i < text.length; i++) {
      int code = text.codeUnitAt(i);
      if (code >= 1569 && code <= 1610) {
        return true;
      }
    }
    return false;
  }

  InputDecoration getInputDecoration() {
    return InputDecoration(
      label: Text(
        lable,
        style: TextStyle(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white, width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 2)),
    );
  }
}

enum charType {
  arabic,
  english,
  space,
  notValid,
}
