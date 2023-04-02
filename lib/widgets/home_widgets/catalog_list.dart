import 'package:first_app/pages/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/catalog.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20.0),
            shrinkWrap: true,
            itemCount: CatalogModels.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModels.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                            catalog: catalog,
                          ),
                        ),
                      ),
                  child: CatalogItem(catalog: catalog));
            })
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatalogModels.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModels.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                            catalog: catalog,
                          ),
                        ),
                      ),
                  child: CatalogItem(catalog: catalog));
            });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({super.key, required this.catalog})
      : assert(catalog != null);
  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
        tag: Key(catalog.id.toString()),
        child: CatalogImage(image: catalog.image),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.xl.lg.color(context.theme.accentColor).make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                AddToCart(
                  catalog,
                  Catalog: catalog,
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ).p(context.isMobile ? 0 : 16),
      )
    ];
    return VxBox(
      child: context.isMobile
          ? Row(
              children: children2,
            )
          : Column(children: children2),
    ).color(context.cardColor).rounded.square(150).make().py16();
  }
}
