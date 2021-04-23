class Singleton {
  static final Singleton _singletonRef = Singleton._internal();
  Singleton._internal();

  factory Singleton() => _singletonRef;

  String user_name = "INSERT USERNAME";

  // int UID
}

