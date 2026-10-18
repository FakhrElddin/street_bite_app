// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'لا توجد عناصر', one: 'عنصر واحد', two: 'عنصران', few: '${count} عناصر', many: '${count} عنصراً', other: '${count} عنصر')}";

  static String m1(price) => "${price} ج.م";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToCart": MessageLookupByLibrary.simpleMessage("أضف للسلة"),
    "addedToFavorites": MessageLookupByLibrary.simpleMessage(
      "تمت الإضافة للمفضلة",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("ستريت بايت"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cartCleared": MessageLookupByLibrary.simpleMessage("تم إفراغ السلة"),
    "cartItemCount": m0,
    "cartTitle": MessageLookupByLibrary.simpleMessage("عربة التسوق"),
    "cashOnDelivery": MessageLookupByLibrary.simpleMessage(
      "الدفع عند الاستلام",
    ),
    "cashOnDeliverySubtitle": MessageLookupByLibrary.simpleMessage(
      "ادفع نقداً عند استلام الطلب",
    ),
    "categoryLabel": MessageLookupByLibrary.simpleMessage("التصنيف"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("تغيير الصورة"),
    "checkout": MessageLookupByLibrary.simpleMessage("إتمام الطلب"),
    "chooseImageSource": MessageLookupByLibrary.simpleMessage(
      "اختر مصدر الصورة",
    ),
    "clearCart": MessageLookupByLibrary.simpleMessage("مسح السلة"),
    "completeCode": MessageLookupByLibrary.simpleMessage("يرجى إكمال الرمز"),
    "confirmOrder": MessageLookupByLibrary.simpleMessage("تأكيد الطلب"),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أكّد كلمة المرور",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الداكن"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("رسوم التوصيل"),
    "dialogCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("خطأ"),
    "dialogOk": MessageLookupByLibrary.simpleMessage("حسناً"),
    "dialogSuccessTitle": MessageLookupByLibrary.simpleMessage("نجاح"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟ "),
    "emailHint": MessageLookupByLibrary.simpleMessage("أدخل بريدك الإلكتروني"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emptyCartSubtitle": MessageLookupByLibrary.simpleMessage(
      "يبدو أنك لم تقم بإضافة أي وجبة إلى عربة التسوق بعد",
    ),
    "emptyCartTitle": MessageLookupByLibrary.simpleMessage("عربة التسوق فارغة"),
    "emptyFavoritesSubtitle": MessageLookupByLibrary.simpleMessage(
      "احفظ وجباتك المفضلة هنا لتجدها بسهولة في أي وقت",
    ),
    "emptyFavoritesTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد وجبات في المفضلة",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterNumbersOnly": MessageLookupByLibrary.simpleMessage(
      "أدخل أرقاماً فقط",
    ),
    "enterSamePassword": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال نفس كلمة المرور",
    ),
    "enterStrongPassword": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال كلمة مرور قوية",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل بريداً إلكترونياً صالحاً",
    ),
    "enterValidUsername": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال اسم مستخدم صالح",
    ),
    "errDatabaseGeneric": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ في قاعدة البيانات. يرجى المحاولة مرة أخرى.",
    ),
    "errEmailInUse": MessageLookupByLibrary.simpleMessage(
      "يوجد حساب مسجل بالفعل بهذا البريد الإلكتروني.",
    ),
    "errFirestoreUnavailable": MessageLookupByLibrary.simpleMessage(
      "خدمة قاعدة البيانات غير متوفرة حالياً. تحقق من الإنترنت.",
    ),
    "errInvalidCredential": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني أو كلمة المرور غير صحيحة.",
    ),
    "errInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "صيغة البريد الإلكتروني غير صالحة.",
    ),
    "errNetworkRequestFailed": MessageLookupByLibrary.simpleMessage(
      "خطأ في الشبكة. يرجى التحقق من اتصالك بالإنترنت.",
    ),
    "errPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "تم رفض الإذن. ليس لديك صلاحية للوصول إلى هذه البيانات.",
    ),
    "errTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "محاولات كثيرة جداً. يرجى المحاولة لاحقاً.",
    ),
    "errUnexpectedAuth": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع أثناء المصادقة.",
    ),
    "errUserDisabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب.",
    ),
    "errUserNotFound": MessageLookupByLibrary.simpleMessage(
      "لا يوجد مستخدم مسجل بهذا البريد الإلكتروني.",
    ),
    "errWeakPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور المدخلة ضعيفة جداً.",
    ),
    "errWrongPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور غير صحيحة.",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "featuredMeals": MessageLookupByLibrary.simpleMessage("الوجبات المميزة"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
    "free": MessageLookupByLibrary.simpleMessage("مجاني"),
    "gallery": MessageLookupByLibrary.simpleMessage("معرض الصور"),
    "guestUser": MessageLookupByLibrary.simpleMessage("زائر"),
    "haveAccount": MessageLookupByLibrary.simpleMessage("لديك حساب بالفعل؟ "),
    "hotOffers": MessageLookupByLibrary.simpleMessage("أقوى العروض"),
    "hotPickBadge": MessageLookupByLibrary.simpleMessage("عرض ساخن"),
    "hotPicks": MessageLookupByLibrary.simpleMessage("أفضل الاختيارات"),
    "instructionsTitle": MessageLookupByLibrary.simpleMessage(
      "طريقة التحضير والتعليمات",
    ),
    "italy": MessageLookupByLibrary.simpleMessage("إيطاليا"),
    "itemAddedToCart": MessageLookupByLibrary.simpleMessage(
      "تمت الإضافة إلى السلة",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "lightMode": MessageLookupByLibrary.simpleMessage("الوضع الفاتح"),
    "liveMenu": MessageLookupByLibrary.simpleMessage("القائمة المباشرة"),
    "logIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logOutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    ),
    "loginAction": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginHeadline": MessageLookupByLibrary.simpleMessage(
      "طعام ومشتريات توصّل إليك",
    ),
    "loginRequiredFavorites": MessageLookupByLibrary.simpleMessage(
      "يرجى تسجيل الدخول لعرض وإدارة المفضلة",
    ),
    "loginRequiredToCheckout": MessageLookupByLibrary.simpleMessage(
      "يرجى تسجيل الدخول لإتمام طلبك",
    ),
    "meals": MessageLookupByLibrary.simpleMessage("الوجبات"),
    "morningDelightsCafe": MessageLookupByLibrary.simpleMessage(
      "مقهى مورنينغ ديلايتس",
    ),
    "nameHint": MessageLookupByLibrary.simpleMessage("أدخل اسمك"),
    "nameLabel": MessageLookupByLibrary.simpleMessage("الاسم"),
    "navCart": MessageLookupByLibrary.simpleMessage("عربة التسوق"),
    "navFavorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "navHome": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "navOrders": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "navProfile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "noFavoritesYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد وجبات مفضلة بعد",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage(
      "لم يتم إجراء أي طلبات بعد",
    ),
    "orderPlacedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد طلبك بنجاح!",
    ),
    "orders": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "ordersHistory": MessageLookupByLibrary.simpleMessage("سجل الطلبات"),
    "ordersTitle": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "originLabel": MessageLookupByLibrary.simpleMessage("المنطقة"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "payWithCard": MessageLookupByLibrary.simpleMessage("الدفع بالبطاقة"),
    "payWithCardSubtitle": MessageLookupByLibrary.simpleMessage(
      "بطاقة ائتمان أو خصم مباشر",
    ),
    "phoneNumberLengthError": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتكون الرقم من 11 رقماً",
    ),
    "priceInEgp": m1,
    "profileTitle": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "readLess": MessageLookupByLibrary.simpleMessage("عرض أقل"),
    "readMore": MessageLookupByLibrary.simpleMessage("قراءة المزيد"),
    "registerHeadline": MessageLookupByLibrary.simpleMessage(
      "وجبات الشارع المفضلة واحتياجاتك اليومية",
    ),
    "removedFromFavorites": MessageLookupByLibrary.simpleMessage(
      "تم الحذف من المفضلة",
    ),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "اختر طريقة الدفع",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "signUpAction": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "subtotal": MessageLookupByLibrary.simpleMessage("المجموع الفرعي"),
    "total": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "uploadingPhoto": MessageLookupByLibrary.simpleMessage(
      "جاري تحديث الصورة...",
    ),
  };
}
