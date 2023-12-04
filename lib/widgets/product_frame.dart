import 'package:flutter/material.dart';
import 'package:flutter_shop_app/pages/product_details_page.dart';
import 'package:flutter_shop_app/widgets/product_card.dart';

class ProductFrame extends StatelessWidget {
  final Map<String, Object> product;
  final int index;
  const ProductFrame({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsPage(product: product);
            },
          ),
        );
      },
      child: ProductCard(
        title: product['title'] as String,
        price: product['price'] as double,
        image: product['imageUrl'] as String,
        backgroundColor: index.isEven
            ? const Color.fromRGBO(216, 240, 253, 1)
            : const Color.fromRGBO(242, 244, 247, 1),
      ),
    );
  }
}
