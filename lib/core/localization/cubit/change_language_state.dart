import 'package:flutter/material.dart';

class ChangeLanguageState {
  final Locale locale;

  const ChangeLanguageState({required this.locale});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeLanguageState &&
          runtimeType == other.runtimeType &&
          locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
