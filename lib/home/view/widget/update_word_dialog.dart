import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/view/widget/arabic_or_eng.dart';
import 'package:note_app/home/view/widget/custom_form.dart';
import 'package:note_app/home/view/widget/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog({
    super.key,
    required this.isExample,
    required this.indexOfDataBase,
    required this.cololrCode,
  });
  final bool isExample;
  final int cololrCode;
  final int indexOfDataBase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Color(widget.cololrCode),
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (context, state) {
          if (state is WriteDataSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDataFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state));
          }
        },
        builder: (context, state) {
          return BlocBuilder<WriteDataCubit, WriteDataState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ArabicOrEngWidget(
                      cololrCode: widget.cololrCode,
                      isArabicIsSelected:
                          WriteDataCubit.get(context).isArabic,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomForm(
                        formKey: formKey,
                        lable:
                            widget.isExample ? "New Examle" : "Similar word"),
                    SizedBox(
                      height: 20,
                    ),
                    DoneButton(
                        colorCode: widget.cololrCode,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (widget.isExample) {
                              WriteDataCubit.get(context)
                                  .addExample(widget.indexOfDataBase);
                            } else {
                              WriteDataCubit.get(context)
                                  .addSimilarWord(widget.indexOfDataBase);
                            }
                            ReadDataCubit.get(context).getWords();
                          }
                        })
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  SnackBar getSnackBar(WriteDataFailureState state) =>
      SnackBar(backgroundColor: Colors.red, content: Text(state.message));
}
