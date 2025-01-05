part of 'write_data_cubit.dart';

@immutable
sealed class WriteDataState {}

final class WriteDataInitialState extends WriteDataState {}
final class WriteDataLoadinglState extends WriteDataState {}
final class WriteDataSuccessState extends WriteDataState {}
final class WriteDataFailureState extends WriteDataState {
  final String message;
  WriteDataFailureState({required this.message});
}
