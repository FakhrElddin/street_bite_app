import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:street_bite_app/core/services/biometric_service.dart';

class FakeLocalAuthentication implements LocalAuthentication {
  final bool canCheck;
  final bool isSupported;
  final List<BiometricType> biometrics;
  final bool shouldAuthenticate;
  final bool throwOnAuth;
  final bool throwOnCheck;

  FakeLocalAuthentication({
    this.canCheck = true,
    this.isSupported = true,
    this.biometrics = const [BiometricType.fingerprint],
    this.shouldAuthenticate = true,
    this.throwOnAuth = false,
    this.throwOnCheck = false,
  });

  @override
  Future<bool> get canCheckBiometrics async {
    if (throwOnCheck) {
      throw PlatformException(code: 'Unavailable');
    }
    return canCheck;
  }

  @override
  Future<bool> isDeviceSupported() async {
    return isSupported;
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return biometrics;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #authenticate) {
      if (throwOnAuth) {
        throw PlatformException(code: 'AuthFailed');
      }
      return Future.value(shouldAuthenticate);
    }
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('BiometricService', () {
    test('canCheckBiometrics returns true when supported and biometrics enrolled', () async {
      final fakeAuth = FakeLocalAuthentication(
        canCheck: true,
        isSupported: true,
        biometrics: [BiometricType.fingerprint],
      );
      final service = BiometricService(auth: fakeAuth);

      final result = await service.canCheckBiometrics();
      expect(result, isTrue);
    });

    test('canCheckBiometrics returns false when no biometrics are enrolled', () async {
      final fakeAuth = FakeLocalAuthentication(
        canCheck: true,
        isSupported: true,
        biometrics: [],
      );
      final service = BiometricService(auth: fakeAuth);

      final result = await service.canCheckBiometrics();
      expect(result, isFalse);
    });

    test('canCheckBiometrics returns false when device is not supported', () async {
      final fakeAuth = FakeLocalAuthentication(
        canCheck: false,
        isSupported: false,
        biometrics: [],
      );
      final service = BiometricService(auth: fakeAuth);

      final result = await service.canCheckBiometrics();
      expect(result, isFalse);
    });

    test('canCheckBiometrics catches PlatformException and returns false', () async {
      final fakeAuth = FakeLocalAuthentication(throwOnCheck: true);
      final service = BiometricService(auth: fakeAuth);

      final result = await service.canCheckBiometrics();
      expect(result, isFalse);
    });

    test('authenticate returns true when authentication succeeds', () async {
      final fakeAuth = FakeLocalAuthentication(shouldAuthenticate: true);
      final service = BiometricService(auth: fakeAuth);

      final result = await service.authenticate();
      expect(result, isTrue);
    });

    test('authenticate returns false when authentication fails/cancelled', () async {
      final fakeAuth = FakeLocalAuthentication(shouldAuthenticate: false);
      final service = BiometricService(auth: fakeAuth);

      final result = await service.authenticate();
      expect(result, isFalse);
    });

    test('authenticate catches PlatformException and returns false', () async {
      final fakeAuth = FakeLocalAuthentication(throwOnAuth: true);
      final service = BiometricService(auth: fakeAuth);

      final result = await service.authenticate();
      expect(result, isFalse);
    });
  });
}
