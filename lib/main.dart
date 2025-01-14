import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/core/utils/theme.dart';
import 'package:note_app/home/controller/read_data_cubit.dart/cubit/read_data_cubit.dart';
import 'package:note_app/home/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:note_app/home/model/hive_constant.dart';
import 'package:note_app/home/model/word_type_adptor.dart';
import 'package:note_app/home/view/screens/home_screen.dart';

import 'core/observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdptor());
  await Hive.openBox(HiveConstant.wordBox);
  Bloc.observer = AppBlocObserver();

  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadDataCubit()..getWords()),
        BlocProvider(create: (context) => WriteDataCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(),
        home: HomeScreen(),
      ),
    );
  }
}
