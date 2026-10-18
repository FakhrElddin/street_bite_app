import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/cart/data/models/order_model.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failures, Unit>> createOrder({
    required OrderModel order,
  });
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirestoreService firestoreService;

  CartRemoteDataSourceImpl({required this.firestoreService});

  @override
  Future<Either<Failures, Unit>> createOrder({
    required OrderModel order,
  }) {
    return firestoreService.saveOrder(
      uid: order.userId,
      orderId: order.id,
      orderData: order.toJson(),
    );
  }
}
