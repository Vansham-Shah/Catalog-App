import "package:first_app/core/store.dart";
import "package:first_app/models/cart.dart";
import "package:first_app/models/catalog.dart";
import "package:first_app/routes.dart";
import "package:first_app/widgets/theme.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'dart:convert';
import "package:velocity_x/velocity_x.dart";
import "package:http/http.dart" as http;

import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  final int days = 30;

  final String name = "Vansham";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final CatalogJson =
        await rootBundle.loadString("assets/files/catalog.json");

    // final response = await http.get(Uri.parse(url));
    // final CatalogJson = response.body;

    final DecodedData = jsonDecode(CatalogJson);
    var ProductData = DecodedData["products"];
    CatalogModels.items =
        List.from(ProductData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
          mutations: {AddMutations, RemoveMutations},
          builder: (context, store, status) => FloatingActionButton(
                backgroundColor: MyTheme.darkblueColor,
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.CartRoute);
                },
                child: Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
              ).badge(
                  color: Vx.red500,
                  size: 22,
                  count: _cart.items.length,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModels.items != null && CatalogModels.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().p16().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
