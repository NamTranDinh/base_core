import 'package:auto_route/auto_route.dart';
import 'package:base_core/cores/constants/app_extension.dart';
import 'package:base_core/cores/dependency_injection/di.dart';
import 'package:base_core/features/login/domain/entities/user_credentials_entity.dart';
import 'package:base_core/features/login/presentation/bloc/login_cubit.dart';
import 'package:core_utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "LoginPageRouter")
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  late LoginCubit loginCubit;

  Future<void> callNativeFunction() async {
    try {
      const platform = MethodChannel('samples.flutter.dev/native');
      final result = await platform.invokeMethod('nativeFunction');
      print('Kết quả từ iOS: $result');
    } on PlatformException catch (e) {
      print('Lỗi: ${e.message}');
    }
  }

  @override
  void initState() {
    loginCubit = getIt<LoginCubit>();
    super.initState();
  }

  Future<void> _submit(BuildContext context) async {
    await callNativeFunction();
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      await loginCubit.login(
        userCredential: UserCredentialsEntity(
          userName: email,
          password: password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == NetworkStatus.loading) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const FlutterLogo(size: 80),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            );
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
