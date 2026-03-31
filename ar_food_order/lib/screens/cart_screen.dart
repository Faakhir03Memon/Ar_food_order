import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/cart_provider.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("YOUR CART"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: items.isEmpty 
        ? _buildEmptyCart(context) 
        : _buildCartList(context, cart, items),
      bottomNavigationBar: items.isEmpty ? null : _buildCheckoutPanel(context, cart),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.white24),
          const SizedBox(height: 20),
          const Text("Your cart is empty", style: TextStyle(color: Colors.white38)),
          const SizedBox(height: 20),
          NeonButton(
            text: "EXPLORE MENU", 
            width: 200,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(BuildContext context, CartProvider cart, List<CartItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: GlassContainer(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item.dish.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.dish.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("\$${item.dish.price.toStringAsFixed(2)}", 
                          style: const TextStyle(color: AppColors.primaryNeon)),
                    ],
                  ),
                ),
                _buildQuantityControl(cart, item),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityControl(CartProvider cart, CartItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_rounded, size: 18),
            onPressed: () => cart.updateQuantity(item.dish.id, item.quantity - 1),
          ),
          Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add_rounded, size: 18),
            onPressed: () => cart.updateQuantity(item.dish.id, item.quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutPanel(BuildContext context, CartProvider cart) {
    return GlassContainer(
      padding: const EdgeInsets.all(30),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount", style: TextStyle(fontSize: 16, color: Colors.white70)),
              Text("\$${cart.totalAmount.toStringAsFixed(2)}", 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryNeon)),
            ],
          ),
          const SizedBox(height: 20),
          NeonButton(
            text: "PROCEED TO CHECKOUT",
            onPressed: () {
              // Final checkout logic placeholder
            },
          ),
        ],
      ),
    );
  }
}
