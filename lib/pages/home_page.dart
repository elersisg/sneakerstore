import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/shoe_model.dart';
import '../widgets/shoe_tile.dart';

class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Sneaker Store'),
actions: [
IconButton(
icon: const Icon(Icons.shopping_cart),
onPressed: () => Navigator.pushNamed(context, '/cart'),
),
],
),
body: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Intro text
const Padding(
padding: EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Premium Sneakers',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 8),
Text(
'Find your perfect pair from our collection',
style: TextStyle(
fontSize: 16,
color: Colors.grey,
),
),
],
),
),

// Sneaker grid
Expanded(
child: Consumer<Cart>(
builder: (context, value, child) {
return GridView.builder(
padding: const EdgeInsets.all(12),
itemCount: value.getShoeList().length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
childAspectRatio: 1 / 1.5,
mainAxisSpacing: 16,
crossAxisSpacing: 16,
),
itemBuilder: (context, index) {
// Get individual shoe
Shoe shoe = value.getShoeList()[index];

// Return shoe tile
return ShoeTile(
shoe: shoe,
onTap: () {
showAddToCartOverlay(context, shoe);
},
);
},
);
},
),
),
],
),
);
}

void showAddToCartOverlay(BuildContext context, Shoe shoe) {
showModalBottomSheet(
context: context,
backgroundColor: Colors.transparent,
builder: (context) => Container(
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.only(
topLeft: Radius.circular(20),
topRight: Radius.circular(20),
),
),
padding: const EdgeInsets.all(20),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Shoe name
Text(
shoe.name,
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 10),

// Price
Text(
'\$${shoe.price}',
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.grey,
),
),
const SizedBox(height: 10),

// Description
Text(
shoe.description,
style: const TextStyle(
fontSize: 14,
color: Colors.grey,
),
),
const SizedBox(height: 20),

// Add to cart button
SizedBox(
width: double.infinity,
child: Consumer<Cart>(
builder: (context, cart, child) {
final bool isInCart = cart.isInCart(shoe);

return ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.black,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 16),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
onPressed: () {
if (isInCart) {
cart.removeItemFromCart(shoe);
} else {
cart.addItemToCart(shoe);
}
Navigator.pop(context);

// Show confirmation
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
isInCart
? '${shoe.name} removed from cart'
    : '${shoe.name} added to cart',
),
duration: const Duration(seconds: 1),
),
);
},
child: Text(
isInCart ? 'Remove from Cart' : 'Add to Cart',
),
);
},
),
),
],
),
),
);
}
}
