import 'package:get_it/get_it.dart';
import 'package:street_bite_app/core/services/auth_service.dart';
import 'package:street_bite_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:street_bite_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:street_bite_app/features/auth/presentation/manager/register_cubit/register_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
  );
  getIt.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
  );
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthRepo>(
    () => AuthRepoImpl(authService: getIt<AuthService>()),
  );
  getIt.registerFactory<AuthService>(() => AuthService());
}
