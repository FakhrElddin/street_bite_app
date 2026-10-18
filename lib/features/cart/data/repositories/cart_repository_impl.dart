import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/utils/internet_checker.dart';
import 'package:street_bite_app/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:street_bite_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:street_bite_app/features/cart/data/models/cart_item_model.dart';
import 'package:street_bite_app/features/cart/data/models/order_model.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failures, List<CartItemEntity>>> getCartItems() async {
    try {
      final models = await localDataSource.getCartItems();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'Failed to retrieve cart items: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<CartItemEntity>>> saveCartItems(
    List<CartItemEntity> items,
  ) async {
    try {
      final models = items.map((e) => CartItemModel.fromEntity(e)).toList();
      await localDataSource.saveCartItems(models);
      return Right(items);
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'Failed to save cart items: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Unit>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return const Right(unit);
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'Failed to clear cart: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failures, Unit>> createOrder({
    required OrderEntity order,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }
    return remoteDataSource.createOrder(
      order: OrderModel.fromEntity(order),
    );
  }
}
