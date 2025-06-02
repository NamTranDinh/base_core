import 'package:base_core/cores/entities/error_res.dart';
import 'package:base_core/cores/network/api_helper.dart';
import 'package:base_core/cores/network/api_result.dart';
import 'package:base_core/cores/network/repo_helper.dart';
import 'package:base_core/features/login/data/models/login_model.dart';
import 'package:base_core/features/login/domain/entities/user_credentials_entity.dart';
import 'package:base_core/features/login/domain/repositories/login_repository.dart';

class LoginDatasource with RepositoryHelper implements LoginRepository {
  LoginDatasource({required this.apiHelper});

  final ApiHelper apiHelper;

  @override
  Future<ApiResult<LoginModel, ErrorRes>> login({
    required UserCredentialsEntity entity,
  }) {
    return checkApiResult(
      apiCallback: apiHelper.post<LoginModel>(
        path: 'auth/login',
        parser: (res) {
          print(res.toJson());
          return res;
        },
      ),
    );
  }
}
