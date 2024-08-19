import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_product_app/models/products.dart';
import 'package:show_product_app/provider/product_provider.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  double price = 0.0;
  String description = '';
  String image = '';
  String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese Enter a Title';
                  }
                  return null;
                },
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese Enter a Price';
                  }
                  return null;
                },
                onChanged: (value) {
                  price = double.parse(value);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese Enter a Description';
                  }
                  return null;
                },
                onChanged: (value) {
                  description = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese Enter a Image URL';
                  }
                  return null;
                },
                onChanged: (value) {
                  image = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plese Enter a Category';
                  }
                  return null;
                },
                onChanged: (value) {
                  category = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Products newProduct = Products(
                          title: title,
                          price: price,
                          description: description,
                          category: category,
                          image: image);

                      final productProvider =
                          Provider.of<ProductProvider>(context, listen: false);

                      try {
                        await productProvider.addNewProduct(newProduct);
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: const Text('Add Product'))
            ],
          ),
        ),
      ),
    );
  }
}
