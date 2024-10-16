abstract class ProfileInfoUpdationStates {}

class ProfileInfoUpdationInitial extends ProfileInfoUpdationStates {}

class ProfileInfoUpdationLoading extends ProfileInfoUpdationStates {}

class ProfileInfoUpdationSuccess extends ProfileInfoUpdationStates {}

class ProfileInfoUpdationError extends ProfileInfoUpdationStates {
  final String error;
  ProfileInfoUpdationError({required this.error});
}
