class Singleton {
  static final Singleton _singletonRef = Singleton._internal();
  Singleton._internal();

  factory Singleton() => _singletonRef;

  String userName = "INSERT USERNAME";

  int uid = 1;
}
