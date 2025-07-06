import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/features/profile/data/model/help_center_model.dart';
import 'help_center_state.dart';

class PolicyCubit extends Cubit<PolicyState> {
  final ApiServices apiServices;

  PolicyCubit({required this.apiServices}) : super(PolicyInitial());

  Future<void> fetchPolicies() async {
    emit(PolicyLoading());
    try {
      final response = await apiServices.getMethod(endPoint: 'policies');
      final policiesJson = response['data'] as List;
      final policies = policiesJson.map((e) => Policy.fromJson(e)).toList();
      if (isClosed) return;
      emit(PolicyLoaded(policies));
    } catch (e) {
      if (isClosed) return;
      emit(PolicyError('❌ ${e.toString()}'));
    }
  }
}
