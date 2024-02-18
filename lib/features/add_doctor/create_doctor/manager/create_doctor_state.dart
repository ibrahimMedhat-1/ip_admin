part of 'create_doctor_cubit.dart';

@immutable
abstract class CreateDoctorState {}

class CreateDoctorInitial extends CreateDoctorState {}

class AddDoctorDataLoading extends CreateDoctorState {}

class AddDoctorDataSuccessfully extends CreateDoctorState {}

class AddDoctorDataSuccessError extends CreateDoctorState {}

class RegisterDoctorLoading extends CreateDoctorState {}

class RegisterDoctorSuccessfully extends CreateDoctorState {}

class RegisterDoctorError extends CreateDoctorState {}

class ClearAllTextFormFields extends CreateDoctorState {}

class ChangeProfilePicture extends CreateDoctorState {}
