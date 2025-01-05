part of 'read_data_cubit.dart';

@immutable
sealed class ReadDataState {}

final class ReadDataInitiState extends ReadDataState {}
final class ReadDataLoadingState extends ReadDataState {}
final class ReadDataSucceState extends ReadDataState {
  final List<WordModel>words;
 ReadDataSucceState({required this.words});
}
final class ReadDataFaildState extends ReadDataState {
  final String message;
  ReadDataFaildState({required this.message});
}
