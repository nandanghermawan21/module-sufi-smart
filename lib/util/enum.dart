class SessionKey {
  static const String lang = "Lang";
  static const String user = "user";
  static const String lockhKey = "lockhKey";
  static const String lockSecret = "lockSecret";
  static const String lockStatus = "authSecret";
}

class ServiceKey {
  static const String action = "action";
}

class ServiceValueAction {
  static const String sendPosition = "sendPosition";
  static const String sendToForeground = "sendToForeground";
}

class Prefkey {
  static const String userId = "UserId";
}

class NotifKey {
  static const String newChat = "NewChat";
  static const String sendChat = "SendChat";
  static const String readChat = "ReadChat";
}

class LockStatus {
  static const String unRegister = "UnRegister";
  static const String opened = "Opened";
  static const String locked = "Locked";
}
