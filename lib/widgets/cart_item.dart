import 'package:flutter/material.dart';
import '../models/shoe_model.dart';

class CartItem extends StatelessWidget {
final Shoe shoe;
final VoidCallback onRemove;

const CartItem({
super.key,
required this.shoe,
required this.onRemove,
});

@override
Widget build(BuildContext context) {
return Container(
margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
boxShadow: [
BoxShadow(
color: Colors.grey.withOpacity(0.2),
spreadRadius: 1,
blurRadius: 4,
offset: const Offset(0, 2),
),
],
),
child: Row(
children: [
// Shoe image
Container(
width: 100,
height: 100,
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: Colors.grey[100],
borderRadius: const BorderRadius.only(
topLeft: Radius.circular(12),
bottomLeft: Radius.circular(12),
),
),
child: Image.asset(
shoe.imagePath,
fit: BoxFit.contain,
),
),

// Shoe details
Expanded(
child: Padding(
padding: const EdgeInsets.all(12),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Name
Text(
shoe.name,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
const SizedBox(height: 4),

// Price
Text(
'\$${shoe.price}',
style: TextStyle(
color: Colors.grey[700],
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),

// Description
Text(
shoe.description,
style: TextStyle(
color: Colors.grey[600],
fontSize: 12,
),
maxLines: 1,
overflow: TextOverflow.ellipsis,
),
],
),
),
),

// Remove button
IconButton(
icon: const Icon(Icons.delete_outline),
color: Colors.red,
onPressed: onRemove,
),
],
),
);
}
}
