import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/view_model/chat_view_model.dart';

class Global {
  String? token = "";
  String? messagingToken;
  Uri? currentDeepLinkUri;
  String ocrKey =
      "706a9adfff2ee547042c40155922144086bb22bf6c558b1ca95fd42293dc0348";
  String notifAppId = "5950883a-0066-4be7-ac84-3d240982ffaf";
  String notifAppKey = "63773c22-a638-49a1-b538-440bdd3b7975";
  CustomerModel? customerModel;
  ChatViewModel? chatViewModel;
}
