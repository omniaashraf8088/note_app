import 'package:flutter/material.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';

class ArabicOrEngWidget extends StatelessWidget {
  const ArabicOrEngWidget(
      {super.key, required this.cololrCode, required this.isArabicIsSelected});
  final bool isArabicIsSelected;
  final int cololrCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getContainerDesign(true, context),
        SizedBox(
          width: 6,
        ),
        getContainerDesign(false, context)
      ],
    );
  }

  InkWell getContainerDesign(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateArabic(buildIsArabic),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: buildIsArabic == isArabicIsSelected
              ? Colors.white
              : Color(cololrCode),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? 'ar' : 'en',
            style: TextStyle(
              color: buildIsArabic == isArabicIsSelected
                  ? Color(cololrCode)
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
