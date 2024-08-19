import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_product_app/models/products.dart';
import 'package:show_product_app/provider/product_provider.dart';
import 'package:show_product_app/screens/add_new_product.dart';
import 'package:show_product_app/screens/single_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    if (productProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (productProvider.errorMessage.isNotEmpty) {
      return Center(
        child: Text(productProvider.errorMessage),
      );
    }

    if (productProvider.products.isEmpty) {
      return const Center(
        child: Text('No Data'),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewProduct()));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              Products product = productProvider.products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SingleProduct(id: product.id!)));
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: ListTile(
                    title: Text(product.title),
                    leading: Image.network(product.image),
                    subtitle: Text(product.price.toString()),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
