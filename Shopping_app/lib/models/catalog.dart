import 'package:flutter/material.dart';

class CatalogModel {
  static List<String> itemNames = [
    'Windows Laptop',
    'Forks',
    'Books',
    'Customized Cups',
    'Mac',
    'Joystick',
    'Berries',
    'Cars',
    'Cycle',
    'Clock',
    'Mobile Phone',
    'Camera',
    'Honey',
    'Kindle',
    'Typewriter',
  ];
  static List<int> itemPrices = [
    1000,
    2,
    10,
    4,
    1100,
    100,
    10,
    123450,
    100,
    30,
    200,
    200,
    6,
    20,
    35,
  ];
  static List<String> imageUrl = [
    'https://picsum.photos/250?image=9',
    'https://fastly.picsum.photos/id/23/3887/4899.jpg?hmac=2fo1Y0AgEkeL2juaEBqKPbnEKm_5Mp0M2nuaVERE6eE',
    'https://fastly.picsum.photos/id/24/4855/1803.jpg?hmac=ICVhP1pUXDLXaTkgwDJinSUS59UWalMxf4SOIWb9Ui4',
    'https://fastly.picsum.photos/id/30/1280/901.jpg?hmac=A_hpFyEavMBB7Dsmmp53kPXKmatwM05MUDatlWSgATE',
    'https://fastly.picsum.photos/id/48/5000/3333.jpg?hmac=y3_1VDNbhii0vM_FN6wxMlvK27vFefflbUSH06z98so',
    'https://fastly.picsum.photos/id/96/4752/3168.jpg?hmac=KNXudB1q84CHl2opIFEY4ph12da5JD5GzKzH5SeuRVM',
    'https://fastly.picsum.photos/id/102/4320/3240.jpg?hmac=ico2KysoswVG8E8r550V_afIWN963F6ygTVrqHeHeRc',
    'https://fastly.picsum.photos/id/133/2742/1828.jpg?hmac=0X5o8bHUICkOIvZHtykCRL50Bjn1N8w1AvkenF7n93E',
    'https://fastly.picsum.photos/id/146/5000/3333.jpg?hmac=xdlFnzoavokA3U-bzo35Vk4jTBKx8C9fqH5IuCPXj2U',
    'https://fastly.picsum.photos/id/175/2896/1944.jpg?hmac=djMSfAvFgWLJ2J3cBulHUAb4yvsQk0d4m4xBJFKzZrs',
    'https://fastly.picsum.photos/id/160/3200/2119.jpg?hmac=cz68HnnDt3XttIwIFu5ymcvkCp-YbkEBAM-Zgq-4DHE',
    'https://fastly.picsum.photos/id/250/4928/3264.jpg?hmac=4oIwzXlpK4KU3wySTnATICCa4H6xwbSGifrxv7GafWU',
    'https://fastly.picsum.photos/id/312/3888/2592.jpg?hmac=Lk5n0q19XuicLgvYPdAr5iML0VbkEADyqgJoHH_5nAs',
    'https://fastly.picsum.photos/id/367/4928/3264.jpg?hmac=H-2OwMlcYm0a--Jd2qaZkXgFZFRxYyGrkrYjupP8Sro',
    'https://fastly.picsum.photos/id/403/3997/2665.jpg?hmac=l04T0quGocuZKSo0CxAJ7aC8CivbrCWV0X0dCzqvb0Y'
  ];
/*
  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}*/
  List<Item> _catalog = [];

  CatalogModel() {
    for (int i = 0; i < itemNames.length; i++) {
      _catalog.add(Item(i, itemNames[i], itemPrices[i], imageUrl[i]));
    }
  }

  Item getById(int id) {
    // if (id >= 0 && id < _catalog.length) {
    return _catalog[id];
    //  }
    // throw Exception("Invalid item ID");
  }

  Item getByPosition(int position) {
    //if (position >= 0 && position < _catalog.length) {
    return _catalog[position];
    //}
    //throw Exception("Invalid item position");
  }
}

/* Item getByPosition(int position) {
    if (_catalog.isEmpty) {
      throw Exception("Catalog is empty");
    }

    int adjustedPosition = position % _catalog.length;
    return _catalog[adjustedPosition];
  }
}*/

@immutable
class Item {
  final int id;
  final String name;
  //final Color color;
  //final int price = 42;
  final String imageUrl;
  final int price;

  Item(this.id, this.name, this.price, this.imageUrl)
  // : color = Colors.primaries[id % Colors.primaries.length];
  {}
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
