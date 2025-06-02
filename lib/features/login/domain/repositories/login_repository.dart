import 'package:base_core/cores/entities/error_res.dart';
import 'package:base_core/cores/network/api_result.dart';
import 'package:base_core/features/login/data/models/login_model.dart';
import 'package:base_core/features/login/domain/entities/user_credentials_entity.dart';

mixin LoginRepository {
  Future<ApiResult<LoginModel,ErrorRes>> login({
    required UserCredentialsEntity entity,
  });
}
