import 'package:base_core/cores/network/api_result.dart';
import 'package:base_core/features/login/domain/entities/user_credentials_entity.dart';
import 'package:base_core/features/login/domain/repositories/login_repository.dart';
import 'package:core_utils/core_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepository}) : super(LoginState.init());

  final LoginRepository loginRepository;

  Future<void> login({
    required UserCredentialsEntity userCredential,
  }) async {
    emit(state.copyWith(loginStatus: NetworkStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    final result = await loginRepository.login(entity: userCredential);

    result.fold(
      onSuccess: (data) {
        emit(state.copyWith(loginStatus: NetworkStatus.success));
      },
      onFailure: (error) {
        emit(state.copyWith(loginStatus: NetworkStatus.failure));
      },
    );
  }
}
