import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_product_app/models/products.dart';
import 'package:show_product_app/provider/product_provider.dart';


class SingleProduct extends StatelessWidget {
  final int id;
  const SingleProduct({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return FutureBuilder(
              future: productProvider.fetchSingleProduct(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
                Products product = snapshot.data!;
                return Column(
                  children: [
                    Image.network(product.image),
                    Text(product.title),
                    Text(product.category),
                    Text(product.price.toString())
                  ],
                );
              });
        },
      ),
    ));
  }
}
