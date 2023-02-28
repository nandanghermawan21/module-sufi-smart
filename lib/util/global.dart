import 'package:intl/intl.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/customernew_model.dart';

class Global {
  String? token = "";
  String? messagingToken;
  Uri? currentDeepLinkUri;
  String ocrKey =
      "706a9adfff2ee547042c40155922144086bb22bf6c558b1ca95fd42293dc0348";
  CustomerModel? customerModel;
  CustomerNewModel? customerNewModel;
  String notifAppId = "8857c98d-aba9-45c2-abd8-692ad94f9521";
  String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
}
