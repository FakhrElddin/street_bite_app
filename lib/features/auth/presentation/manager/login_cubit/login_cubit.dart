import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  final LoginUseCase loginUseCase;

  static LoginCubit get(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  void loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    var either = await loginUseCase.call(
      email: email,
      password: password,
    );
    either.fold(
      (failure) => emit(LoginError(failure: failure)),
      (user) => emit(LoginSuccess(userEntity: user)),
    );
  }
}
