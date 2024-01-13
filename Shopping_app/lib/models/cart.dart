import 'package:flutter/foundation.dart';
import 'package:provider_1/models/catalog.dart';

class CartModel extends ChangeNotifier {
  late CatalogModel _catalog;

  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;

    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);

    notifyListeners();
  }
/*
  void remove(Item item) {
    items.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }*/

  void remove(Item item) {
    _itemIds.remove(item.id);

    notifyListeners();
  }

  void clear() {
    _itemIds.clear();
    notifyListeners();
  }
}
