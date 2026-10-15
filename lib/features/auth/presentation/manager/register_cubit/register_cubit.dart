import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this._registerUseCase}) : super(RegisterInitial());

  final RegisterUseCase _registerUseCase;

  static RegisterCubit get(BuildContext context) =>
      BlocProvider.of<RegisterCubit>(context);

  void registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    var either = await _registerUseCase.call(
      name: name,
      email: email,
      password: password,
    );
    either.fold(
      (failure) => emit(RegisterError(failure: failure)),
      (user) => emit(RegisterSuccess(userEntity: user)),
    );
  }
}
