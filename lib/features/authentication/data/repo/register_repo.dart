import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/data/models/register_model.dart';

class RegisterRepo {
  final ApiServices apiServices;

  RegisterRepo({required this.apiServices});

  Future register({required RegisterModel registerModel}) async {
    var data = await apiServices.postMethod(
        endPoint: ApiEndpoints.register, data: registerModel.toJson());
    return data;
  }
}
