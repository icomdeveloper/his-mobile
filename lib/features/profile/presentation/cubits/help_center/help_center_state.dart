


import 'package:his/features/profile/data/model/help_center_model.dart';



abstract class PolicyState {}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  final List<Policy> policies;
  PolicyLoaded(this.policies);
}

class PolicyError extends PolicyState {
  final String message;
  PolicyError(this.message);
}