// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Street Bite`
  String get appName {
    return Intl.message('Street Bite', name: 'appName', desc: '', args: []);
  }

  /// `Food and groceries delivered to you`
  String get loginHeadline {
    return Intl.message(
      'Food and groceries delivered to you',
      name: 'loginHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Enter Your Email`
  String get emailHint {
    return Intl.message(
      'Enter Your Email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Enter Your Password`
  String get passwordHint {
    return Intl.message(
      'Enter Your Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Don't have account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get signUpAction {
    return Intl.message('SIGN UP', name: 'signUpAction', desc: '', args: []);
  }

  /// `Your favorite street bites and essentials`
  String get registerHeadline {
    return Intl.message(
      'Your favorite street bites and essentials',
      name: 'registerHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameLabel {
    return Intl.message('Name', name: 'nameLabel', desc: '', args: []);
  }

  /// `Enter Your Name`
  String get nameHint {
    return Intl.message(
      'Enter Your Name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Your Password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `have account? `
  String get haveAccount {
    return Intl.message(
      'have account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get loginAction {
    return Intl.message('LOG IN', name: 'loginAction', desc: '', args: []);
  }

  /// `this field is required`
  String get fieldRequired {
    return Intl.message(
      'this field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `enter valid email`
  String get enterValidEmail {
    return Intl.message(
      'enter valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `please enter strong password`
  String get enterStrongPassword {
    return Intl.message(
      'please enter strong password',
      name: 'enterStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `please enter same password`
  String get enterSamePassword {
    return Intl.message(
      'please enter same password',
      name: 'enterSamePassword',
      desc: '',
      args: [],
    );
  }

  /// `please enter valid username`
  String get enterValidUsername {
    return Intl.message(
      'please enter valid username',
      name: 'enterValidUsername',
      desc: '',
      args: [],
    );
  }

  /// `enter numbers only`
  String get enterNumbersOnly {
    return Intl.message(
      'enter numbers only',
      name: 'enterNumbersOnly',
      desc: '',
      args: [],
    );
  }

  /// `enter value must equal 11 digit`
  String get phoneNumberLengthError {
    return Intl.message(
      'enter value must equal 11 digit',
      name: 'phoneNumberLengthError',
      desc: '',
      args: [],
    );
  }

  /// `please complete code`
  String get completeCode {
    return Intl.message(
      'please complete code',
      name: 'completeCode',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Orders`
  String get navOrders {
    return Intl.message('Orders', name: 'navOrders', desc: '', args: []);
  }

  /// `Favorites`
  String get navFavorites {
    return Intl.message('Favorites', name: 'navFavorites', desc: '', args: []);
  }

  /// `Cart`
  String get navCart {
    return Intl.message('Cart', name: 'navCart', desc: '', args: []);
  }

  /// `Profile`
  String get navProfile {
    return Intl.message('Profile', name: 'navProfile', desc: '', args: []);
  }

  /// `Featured Meals`
  String get featuredMeals {
    return Intl.message(
      'Featured Meals',
      name: 'featuredMeals',
      desc: '',
      args: [],
    );
  }

  /// `Hot Offers`
  String get hotOffers {
    return Intl.message('Hot Offers', name: 'hotOffers', desc: '', args: []);
  }

  /// `Hot Picks`
  String get hotPicks {
    return Intl.message('Hot Picks', name: 'hotPicks', desc: '', args: []);
  }

  /// `Live Menu`
  String get liveMenu {
    return Intl.message('Live Menu', name: 'liveMenu', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Hot Pick`
  String get hotPickBadge {
    return Intl.message('Hot Pick', name: 'hotPickBadge', desc: '', args: []);
  }

  /// `Meals`
  String get meals {
    return Intl.message('Meals', name: 'meals', desc: '', args: []);
  }

  /// `{price} L.E`
  String priceInEgp(String price) {
    return Intl.message(
      '$price L.E',
      name: 'priceInEgp',
      desc: '',
      args: [price],
    );
  }

  /// `Italy`
  String get italy {
    return Intl.message('Italy', name: 'italy', desc: '', args: []);
  }

  /// `Morning Delights Café`
  String get morningDelightsCafe {
    return Intl.message(
      'Morning Delights Café',
      name: 'morningDelightsCafe',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message('Light Mode', name: 'lightMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `Cart`
  String get cartTitle {
    return Intl.message('Cart', name: 'cartTitle', desc: '', args: []);
  }

  /// `Orders`
  String get ordersTitle {
    return Intl.message('Orders', name: 'ordersTitle', desc: '', args: []);
  }

  /// `Favorites`
  String get favoritesTitle {
    return Intl.message(
      'Favorites',
      name: 'favoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `Success`
  String get dialogSuccessTitle {
    return Intl.message(
      'Success',
      name: 'dialogSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get dialogOk {
    return Intl.message('OK', name: 'dialogOk', desc: '', args: []);
  }

  /// `Cancel`
  String get dialogCancel {
    return Intl.message('Cancel', name: 'dialogCancel', desc: '', args: []);
  }

  /// `The password provided is too weak.`
  String get errWeakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'errWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists for that email.`
  String get errEmailInUse {
    return Intl.message(
      'An account already exists for that email.',
      name: 'errEmailInUse',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get errInvalidEmail {
    return Intl.message(
      'The email address is not valid.',
      name: 'errInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email address.`
  String get errUserNotFound {
    return Intl.message(
      'No user found for that email address.',
      name: 'errUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get errWrongPassword {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'errWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `This user account has been disabled.`
  String get errUserDisabled {
    return Intl.message(
      'This user account has been disabled.',
      name: 'errUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get errTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'errTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your internet connection.`
  String get errNetworkRequestFailed {
    return Intl.message(
      'Network error. Please check your internet connection.',
      name: 'errNetworkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password. Please check your credentials.`
  String get errInvalidCredential {
    return Intl.message(
      'Invalid email or password. Please check your credentials.',
      name: 'errInvalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected authentication error occurred.`
  String get errUnexpectedAuth {
    return Intl.message(
      'An unexpected authentication error occurred.',
      name: 'errUnexpectedAuth',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied. You do not have access to this data.`
  String get errPermissionDenied {
    return Intl.message(
      'Permission denied. You do not have access to this data.',
      name: 'errPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Firestore service is currently unavailable. Check your internet.`
  String get errFirestoreUnavailable {
    return Intl.message(
      'Firestore service is currently unavailable. Check your internet.',
      name: 'errFirestoreUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `A database error occurred. Please try again.`
  String get errDatabaseGeneric {
    return Intl.message(
      'A database error occurred. Please try again.',
      name: 'errDatabaseGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructionsTitle {
    return Intl.message(
      'Instructions',
      name: 'instructionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Read less`
  String get readLess {
    return Intl.message('Read less', name: 'readLess', desc: '', args: []);
  }

  /// `Category`
  String get categoryLabel {
    return Intl.message('Category', name: 'categoryLabel', desc: '', args: []);
  }

  /// `Origin`
  String get originLabel {
    return Intl.message('Origin', name: 'originLabel', desc: '', args: []);
  }

  /// `Added to cart`
  String get itemAddedToCart {
    return Intl.message(
      'Added to cart',
      name: 'itemAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites`
  String get addedToFavorites {
    return Intl.message(
      'Added to favorites',
      name: 'addedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get removedFromFavorites {
    return Intl.message(
      'Removed from favorites',
      name: 'removedFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get emptyCartTitle {
    return Intl.message(
      'Your cart is empty',
      name: 'emptyCartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't added anything to your cart yet`
  String get emptyCartSubtitle {
    return Intl.message(
      'Looks like you haven\'t added anything to your cart yet',
      name: 'emptyCartSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No favorites yet`
  String get emptyFavoritesTitle {
    return Intl.message(
      'No favorites yet',
      name: 'emptyFavoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save meals to your favorites to find them easily here`
  String get emptyFavoritesSubtitle {
    return Intl.message(
      'Save meals to your favorites to find them easily here',
      name: 'emptyFavoritesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Delivery Fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message('Free', name: 'free', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message('Clear Cart', name: 'clearCart', desc: '', args: []);
  }

  /// `Cart cleared`
  String get cartCleared {
    return Intl.message(
      'Cart cleared',
      name: 'cartCleared',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to manage your favorites`
  String get loginRequiredFavorites {
    return Intl.message(
      'Please log in to manage your favorites',
      name: 'loginRequiredFavorites',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 item} other{{count} items}}`
  String cartItemCount(num count) {
    return Intl.plural(
      count,
      one: '1 item',
      other: '$count items',
      name: 'cartItemCount',
      desc: '',
      args: [count],
    );
  }

  /// `Select Payment Method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay with Card`
  String get payWithCard {
    return Intl.message(
      'Pay with Card',
      name: 'payWithCard',
      desc: '',
      args: [],
    );
  }

  /// `Credit or debit card`
  String get payWithCardSubtitle {
    return Intl.message(
      'Credit or debit card',
      name: 'payWithCardSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Pay with cash upon arrival`
  String get cashOnDeliverySubtitle {
    return Intl.message(
      'Pay with cash upon arrival',
      name: 'cashOnDeliverySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully!`
  String get orderPlacedSuccessfully {
    return Intl.message(
      'Your order has been placed successfully!',
      name: 'orderPlacedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to place an order`
  String get loginRequiredToCheckout {
    return Intl.message(
      'Please log in to place an order',
      name: 'loginRequiredToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get ordersHistory {
    return Intl.message(
      'Order History',
      name: 'ordersHistory',
      desc: '',
      args: [],
    );
  }

  /// `No orders placed yet`
  String get noOrdersYet {
    return Intl.message(
      'No orders placed yet',
      name: 'noOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `No favorites added yet`
  String get noFavoritesYet {
    return Intl.message(
      'No favorites added yet',
      name: 'noFavoritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Choose Image Source`
  String get chooseImageSource {
    return Intl.message(
      'Choose Image Source',
      name: 'chooseImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Updating photo...`
  String get uploadingPhoto {
    return Intl.message(
      'Updating photo...',
      name: 'uploadingPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Change Photo`
  String get changePhoto {
    return Intl.message(
      'Change Photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Guest User`
  String get guestUser {
    return Intl.message('Guest User', name: 'guestUser', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get logOutConfirmMessage {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logOutConfirmMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
