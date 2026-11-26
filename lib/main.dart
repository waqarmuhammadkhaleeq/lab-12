import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (_) => CartModel(), child: const MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: ProductsScreen());
}

const products = [
  Product('Book', 30),
  Product('Headphones', 80),
  Product('Pen', 5),
  Product('Bag', 45),
];

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final count = context.watch<CartModel>().count;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            child: Text('Cart ($count)'),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final p in products)
            ListTile(
              title: Text(p.name),
              subtitle: Text('\$${p.price}'),
              trailing: ElevatedButton(
                onPressed: () => context.read<CartModel>().add(p),
                child: const Text('Add'),
              ),
            ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final p in cart.items)
                  ListTile(title: Text(p.name), subtitle: Text('\$${p.price}')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total: \$${cart.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
