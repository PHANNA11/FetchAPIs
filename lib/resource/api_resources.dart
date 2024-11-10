class APIRoute {
  final String _mainURL = 'https://fakestoreapi.com';
  String get products => '$_mainURL/products';
  String get carts => '$_mainURL/carts';
  String get users => '$_mainURL/users';
}
