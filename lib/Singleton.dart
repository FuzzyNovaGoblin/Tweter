class Singleton {
  static final Singleton _singletonRef = Singleton._internal();
  Singleton._internal();

  factory Singleton() => _singletonRef;

  String userName = "INSERT USERNAME";
  int uid = 1;
  List<int> followingIds= [];

  // -----Routes-----
  static const String timeLineRoute = "/timeline";
  static const String loginRoute = "/login";
  static const String profileRoute = "/profile";
  static const String peopleRoute = "/people";
}
