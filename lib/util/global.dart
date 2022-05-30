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
}
