// ignore_for_file: depend_on_referenced_packages
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_local_data_source.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_remote_data_source.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';
import 'package:street_bite_app/features/home/data/repositories/meals_repository_impl.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class FakeConnectivityPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements ConnectivityPlatform {
  List<ConnectivityResult> connectivityResults = [ConnectivityResult.wifi];

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return connectivityResults;
  }
}

class FakeRemoteDataSource implements MealsRemoteDataSource {
  Either<Failures, MealsResponseEntity>? response;

  @override
  Future<Either<Failures, MealsResponseEntity>> getMealsByFirstLetter({
    required String letter,
  }) async {
    return response!;
  }
}

class FakeLocalDataSource implements MealsLocalDataSource {
  MealsResponseDm? cached;
  bool cacheCalled = false;

  @override
  Future<void> cacheMeals(MealsResponseDm mealsResponse, {String letter = 'a'}) async {
    cached = mealsResponse;
    cacheCalled = true;
  }

  @override
  Future<void> clearCachedMeals({String letter = 'a'}) async {
    cached = null;
  }

  @override
  Future<MealsResponseDm?> getCachedMeals({String letter = 'a'}) async {
    return cached;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeConnectivityPlatform fakeConnectivity;
  late FakeRemoteDataSource remoteDataSource;
  late FakeLocalDataSource localDataSource;
  late MealsRepositoryImpl repository;

  final testMeal = MealItemDm(idMeal: '1', strMeal: 'Test Meal');
  final mealsResponse = MealsResponseDm(meals: [testMeal]);

  setUp(() {
    fakeConnectivity = FakeConnectivityPlatform();
    ConnectivityPlatform.instance = fakeConnectivity;

    remoteDataSource = FakeRemoteDataSource();
    localDataSource = FakeLocalDataSource();
    repository = MealsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  test('when online, fetches from remote and caches result', () async {
    fakeConnectivity.connectivityResults = [ConnectivityResult.wifi];
    remoteDataSource.response = Right(mealsResponse);

    final result = await repository.getMealsByFirstLetter(letter: 'a');

    expect(result.isRight(), isTrue);
    expect(localDataSource.cacheCalled, isTrue);
    expect(localDataSource.cached?.meals?.first.strMeal, 'Test Meal');
  });

  test('when online but remote fails, falls back to local cache if available', () async {
    fakeConnectivity.connectivityResults = [ConnectivityResult.wifi];
    remoteDataSource.response = Left(ServerFailure(errorMessage: '500'));
    localDataSource.cached = mealsResponse;

    final result = await repository.getMealsByFirstLetter(letter: 'a');

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('Expected right'),
      (response) => expect(response.meals?.first.idMeal, '1'),
    );
  });

  test('when offline, returns cached meals if available', () async {
    fakeConnectivity.connectivityResults = [ConnectivityResult.none];
    localDataSource.cached = mealsResponse;

    final result = await repository.getMealsByFirstLetter(letter: 'a');

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('Expected right'),
      (response) => expect(response.meals?.first.idMeal, '1'),
    );
  });

  test('when offline and no cached meals, returns NetworkFailure', () async {
    fakeConnectivity.connectivityResults = [ConnectivityResult.none];
    localDataSource.cached = null;

    final result = await repository.getMealsByFirstLetter(letter: 'a');

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<NetworkFailure>()),
      (_) => fail('Expected left'),
    );
  });
}
