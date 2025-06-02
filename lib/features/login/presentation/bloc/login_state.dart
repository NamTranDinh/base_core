part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginStatus,
    this.userCredentialsEntity,
    this.message,
  });

  factory LoginState.init() =>
      const LoginState(loginStatus: NetworkStatus.init);

  final NetworkStatus? loginStatus;
  final UserCredentialsEntity? userCredentialsEntity;
  final String? message;

  LoginState copyWith({
    NetworkStatus? loginStatus,
    UserCredentialsEntity? userCredentialsEntity,
    String? message,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      userCredentialsEntity:
          userCredentialsEntity ?? this.userCredentialsEntity,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        loginStatus,
        userCredentialsEntity,
        message,
      ];
}
