// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 item', other: '${count} items')}";

  static String m1(price) => "${price} L.E";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "addedToFavorites": MessageLookupByLibrary.simpleMessage(
      "Added to favorites",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Street Bite"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cartCleared": MessageLookupByLibrary.simpleMessage("Cart cleared"),
    "cartItemCount": m0,
    "cartTitle": MessageLookupByLibrary.simpleMessage("Cart"),
    "cashOnDelivery": MessageLookupByLibrary.simpleMessage("Cash on Delivery"),
    "cashOnDeliverySubtitle": MessageLookupByLibrary.simpleMessage(
      "Pay with cash upon arrival",
    ),
    "categoryLabel": MessageLookupByLibrary.simpleMessage("Category"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Change Photo"),
    "checkout": MessageLookupByLibrary.simpleMessage("Checkout"),
    "chooseImageSource": MessageLookupByLibrary.simpleMessage(
      "Choose Image Source",
    ),
    "clearCart": MessageLookupByLibrary.simpleMessage("Clear Cart"),
    "completeCode": MessageLookupByLibrary.simpleMessage(
      "please complete code",
    ),
    "confirmOrder": MessageLookupByLibrary.simpleMessage("Confirm Order"),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Confirm Your Password",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("Delivery Fee"),
    "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "dialogOk": MessageLookupByLibrary.simpleMessage("OK"),
    "dialogSuccessTitle": MessageLookupByLibrary.simpleMessage("Success"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have account? ",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("Enter Your Email"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emptyCartSubtitle": MessageLookupByLibrary.simpleMessage(
      "Looks like you haven\'t added anything to your cart yet",
    ),
    "emptyCartTitle": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty",
    ),
    "emptyFavoritesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Save meals to your favorites to find them easily here",
    ),
    "emptyFavoritesTitle": MessageLookupByLibrary.simpleMessage(
      "No favorites yet",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterNumbersOnly": MessageLookupByLibrary.simpleMessage(
      "enter numbers only",
    ),
    "enterSamePassword": MessageLookupByLibrary.simpleMessage(
      "please enter same password",
    ),
    "enterStrongPassword": MessageLookupByLibrary.simpleMessage(
      "please enter strong password",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "enter valid email",
    ),
    "enterValidUsername": MessageLookupByLibrary.simpleMessage(
      "please enter valid username",
    ),
    "errDatabaseGeneric": MessageLookupByLibrary.simpleMessage(
      "A database error occurred. Please try again.",
    ),
    "errEmailInUse": MessageLookupByLibrary.simpleMessage(
      "An account already exists for that email.",
    ),
    "errFirestoreUnavailable": MessageLookupByLibrary.simpleMessage(
      "Firestore service is currently unavailable. Check your internet.",
    ),
    "errInvalidCredential": MessageLookupByLibrary.simpleMessage(
      "Invalid email or password. Please check your credentials.",
    ),
    "errInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "The email address is not valid.",
    ),
    "errNetworkRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Network error. Please check your internet connection.",
    ),
    "errPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permission denied. You do not have access to this data.",
    ),
    "errTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "errUnexpectedAuth": MessageLookupByLibrary.simpleMessage(
      "An unexpected authentication error occurred.",
    ),
    "errUserDisabled": MessageLookupByLibrary.simpleMessage(
      "This user account has been disabled.",
    ),
    "errUserNotFound": MessageLookupByLibrary.simpleMessage(
      "No user found for that email address.",
    ),
    "errWeakPassword": MessageLookupByLibrary.simpleMessage(
      "The password provided is too weak.",
    ),
    "errWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Wrong password provided for that user.",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("Favorites"),
    "featuredMeals": MessageLookupByLibrary.simpleMessage("Featured Meals"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "this field is required",
    ),
    "free": MessageLookupByLibrary.simpleMessage("Free"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "guestUser": MessageLookupByLibrary.simpleMessage("Guest User"),
    "haveAccount": MessageLookupByLibrary.simpleMessage("have account? "),
    "hotOffers": MessageLookupByLibrary.simpleMessage("Hot Offers"),
    "hotPickBadge": MessageLookupByLibrary.simpleMessage("Hot Pick"),
    "hotPicks": MessageLookupByLibrary.simpleMessage("Hot Picks"),
    "instructionsTitle": MessageLookupByLibrary.simpleMessage("Instructions"),
    "italy": MessageLookupByLibrary.simpleMessage("Italy"),
    "itemAddedToCart": MessageLookupByLibrary.simpleMessage("Added to cart"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
    "liveMenu": MessageLookupByLibrary.simpleMessage("Live Menu"),
    "logIn": MessageLookupByLibrary.simpleMessage("Log In"),
    "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
    "logOutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "loginAction": MessageLookupByLibrary.simpleMessage("LOG IN"),
    "loginHeadline": MessageLookupByLibrary.simpleMessage(
      "Food and groceries delivered to you",
    ),
    "loginRequiredFavorites": MessageLookupByLibrary.simpleMessage(
      "Please log in to manage your favorites",
    ),
    "loginRequiredToCheckout": MessageLookupByLibrary.simpleMessage(
      "Please log in to place an order",
    ),
    "meals": MessageLookupByLibrary.simpleMessage("Meals"),
    "morningDelightsCafe": MessageLookupByLibrary.simpleMessage(
      "Morning Delights Café",
    ),
    "nameHint": MessageLookupByLibrary.simpleMessage("Enter Your Name"),
    "nameLabel": MessageLookupByLibrary.simpleMessage("Name"),
    "navCart": MessageLookupByLibrary.simpleMessage("Cart"),
    "navFavorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navOrders": MessageLookupByLibrary.simpleMessage("Orders"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "noFavoritesYet": MessageLookupByLibrary.simpleMessage(
      "No favorites added yet",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("No orders placed yet"),
    "orderPlacedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your order has been placed successfully!",
    ),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "ordersHistory": MessageLookupByLibrary.simpleMessage("Order History"),
    "ordersTitle": MessageLookupByLibrary.simpleMessage("Orders"),
    "originLabel": MessageLookupByLibrary.simpleMessage("Origin"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Enter Your Password"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "payWithCard": MessageLookupByLibrary.simpleMessage("Pay with Card"),
    "payWithCardSubtitle": MessageLookupByLibrary.simpleMessage(
      "Credit or debit card",
    ),
    "phoneNumberLengthError": MessageLookupByLibrary.simpleMessage(
      "enter value must equal 11 digit",
    ),
    "priceInEgp": m1,
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "readLess": MessageLookupByLibrary.simpleMessage("Read less"),
    "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
    "registerHeadline": MessageLookupByLibrary.simpleMessage(
      "Your favorite street bites and essentials",
    ),
    "removedFromFavorites": MessageLookupByLibrary.simpleMessage(
      "Removed from favorites",
    ),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Select Payment Method",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpAction": MessageLookupByLibrary.simpleMessage("SIGN UP"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "uploadingPhoto": MessageLookupByLibrary.simpleMessage("Updating photo..."),
  };
}
