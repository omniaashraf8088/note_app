import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/view/widget/color_widget.dart';

class AddWordDialog extends StatelessWidget {
  const AddWordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<WriteDataCubit,WriteDataState>(builder: (context,State){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorWidget(activeColor: WriteDataCubit.get(context).colorCode)
          ],
        );
      }),
    );
  }
}