import 'package:flutter/material.dart';
import 'package:flutter_shop_app/utils/global_variables.dart';
import 'package:flutter_shop_app/widgets/product_frame.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', "Nike", 'Bata'];
  late String selectedFilter;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  List<ProductFrame> _buildGridList() {
    final productList = products
        .where((item) =>
            selectedFilter == 'All' || item['company'] == selectedFilter)
        .toList();

    return List.generate(productList.length, (i) {
      final product = productList[i];
      return ProductFrame(index: i, product: product);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screen = MediaQuery.of(context);
    // final screenSize = MediaQuery.of(context).size;

    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(225, 225, 225, 1),
        ),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
        ));

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: const TextStyle(fontSize: 16),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(242, 244, 247, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(242, 244, 247, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                crossAxisCount: constraints.maxWidth > 650 ? 2 : 1,
                childAspectRatio: 10 / 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: _buildGridList(),
              );
            }),
          ),

          // Expanded(
          //   child: LayoutBuilder(builder: (context, constraints) {
          //     return GridView.builder(
          //         padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: constraints.maxWidth > 650 ? 2 : 1,
          //           childAspectRatio: 10 / 6,
          //           mainAxisSpacing: 10,
          //           crossAxisSpacing: 10,
          //         ),
          //         itemCount: products.length,
          //         itemBuilder: (context, index) {
          //           final product = products[index];
          //           if (selectedFilter == 'All' ||
          //               product['company'] == selectedFilter) {
          //             return ProductFrame(index: index, product: product);
          //           }
          //         });
          //   }),
          // ),

          // Expanded(
          //   child: LayoutBuilder(builder: (context, constraints) {
          //     // print(constraints.maxHeight);
          //     // print(constraints.maxWidth);
          //     // print(constraints.minHeight);
          //     // print(constraints.minWidth);
          //     // return const Text("HI");
          //     if (constraints.maxWidth > 650) {
          //       return GridView.builder(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             childAspectRatio:  10 / 6,
          //           ),
          //           itemCount: products.length,
          //           itemBuilder: (context, index) {
          //             final product = products[index];
          //             return ProductFrame(index: index, product: product);
          //           });
          //     } else {
          //       return ListView.builder(
          //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //         itemCount: products.length,
          //         itemBuilder: (context, index) {
          //           final product = products[index];
          //           return ProductFrame(index: index, product: product);
          //         },
          //       );
          //     }
          //   }),
          // ),

          // Expanded(
          //   child: screenSize.width > 650
          //       ? GridView.builder(
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             childAspectRatio: 2,
          //           ),
          //           itemCount: products.length,
          //           itemBuilder: (context, index) {
          //             final product = products[index];
          //             return ProductFrame(index: index, product: product);
          //           })
          //       : ListView.builder(
          //           itemCount: products.length,
          //           itemBuilder: (context, index) {
          //             final product = products[index];
          //             return ProductFrame(index: index, product: product);
          //           },
          //         ),
          // )
        ],
      ),
    );
  }
}
