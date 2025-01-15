import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/view/widget/arabic_or_eng.dart';
import 'package:note_app/home/view/widget/color_widget.dart';
import 'package:note_app/home/view/widget/custom_form.dart';
import 'package:note_app/home/view/widget/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
          listener: (context, state) {
        if (state is WriteDataSuccessState) {
          Navigator.pop(context);
        } else {
          if (state is WriteDataFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(state.message));
          }
        }
        ;
      }, builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 750),
          color: Color(context.read<WriteDataCubit>().colorCode),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArabicOrEngWidget(
                      cololrCode: WriteDataCubit.get(context).colorCode,
                      isArabicIsSelected: WriteDataCubit.get(context).isArabic),
                  SizedBox(
                    height: 12,
                  ),
                  ColorWidget(
                      activeColor: WriteDataCubit.get(context).colorCode),
                  SizedBox(height: 10),
                  CustomForm(
                    formKey: formKey,
                    controller:
                        WriteDataCubit.get(context).wordEditingController,
                    lable: 'New Word',
                  ),
                  SizedBox(height: 15),
                  DoneButton(
                      colorCode: WriteDataCubit.get(context).colorCode,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          WriteDataCubit.get(context).addWord();
                          ReadDataCubit.get(context).getWords();
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  SnackBar getSnackBar(String message) => SnackBar(
      content: Text(message,
          style: TextStyle(
            backgroundColor: Colors.red,
          )));
}
