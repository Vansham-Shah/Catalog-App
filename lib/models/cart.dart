// import 'dart:ffi';
import 'package:first_app/core/store.dart';
import 'package:first_app/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  // catalog field ----only catalog can be used without get and set and not privately
  late CatalogModels _catalog;

  // collection of IDs : store id of each item
  final List<num> _itemIds = [];

  // get catalog
  CatalogModels get catalog => _catalog;

  // set catalog
  set catalog(CatalogModels newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  // get items in the cart
  List<Item> get items =>
      _itemIds.map((id) => _catalog.GetById(id as int)).toList();

  // get total price
  num get totalprice =>
      items.fold(0, (totalvalue, current) => totalvalue + current.price);


  toMap() {}
}

class AddMutations extends VxMutation<MyStore> {
  final Item item;

  AddMutations(this.item);
  @override
  perform() {
    store?.cart._itemIds.add(item.id);
  }
}

class RemoveMutations extends VxMutation<MyStore> {
  final Item item;

  RemoveMutations(this.item);
  @override
  perform() {
    store?.cart._itemIds.remove(item.id);
  }
}
