import 'package:first_app/core/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/cart.dart';
import '../../models/catalog.dart';

class AddToCart extends StatelessWidget {
  final Item Catalog;
  AddToCart(
    Item catalog, {
    super.key,
    required this.Catalog,
  });

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutations, RemoveMutations]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isIncart = _cart.items.contains(Catalog);
    return ElevatedButton(
        onPressed: () {
          if (!isIncart) {
            AddMutations(Catalog); // setState(() {});
          }
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(context.theme.buttonColor),
            shape: MaterialStateProperty.all(StadiumBorder())),
        child:
            isIncart ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus));
  }

  listen(BuildContext context) => VxState.watch(context, on: []);
}
