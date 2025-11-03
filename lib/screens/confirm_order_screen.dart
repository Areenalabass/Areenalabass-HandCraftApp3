import 'package:flutter/material.dart';
import 'package:handcrafts/providers/cart_provider.dart'; // Import CartItem model
import 'payment_details_screen.dart';

class ConfirmOrderPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const ConfirmOrderPage({super.key, required this.cartItems});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late List<Map<String, dynamic>> localCartItems;
  String? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Convert List<CartItem> to the local List<Map<String, dynamic>> and add a quantity field.
    localCartItems = widget.cartItems.map((item) => {
      'id': item.id,
      'productId': item.productId,
      'title': item.name, // Use 'name' from CartItem as 'title'
      'price': item.price,
      'image': item.image,
      'quantity': 1, // Initialize quantity to 1
    }).toList();
  }

  void _increaseQuantity(int index) {
    setState(() {
      localCartItems[index]["quantity"]++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (localCartItems[index]["quantity"] > 1) {
        localCartItems[index]["quantity"]--;
      }
    });
  }

  double get subtotal {
    double sum = 0;
    for (var item in localCartItems) {
      sum += item["price"] * item["quantity"];
    }
    return sum;
  }

  double get total => subtotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B4BDB),
        elevation: 0,
        title: const Text(
          "Confirm Order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: localCartItems.length, // Use local list
                itemBuilder: (context, index) {
                  final item = localCartItems[index]; // Use local list item
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEBFD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item["image"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _increaseQuantity(index),
                                    icon: const Icon(Icons.add_circle_outline, size: 18),
                                  ),
                                  Text(
                                    item["quantity"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () => _decreaseQuantity(index),
                                    icon: const Icon(Icons.remove_circle_outline, size: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(item["price"] * item["quantity"]).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Payment",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
            ),
            ListTile(
              leading: Radio<String>(
                value: "card",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
              title: const Text("Credit / Debit Card"),
            ),
            ListTile(
              leading: Radio<String>(
                value: "cash",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
              title: const Text("Cash on Delivery"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:",
                    style: TextStyle(fontSize: 16, color: Colors.black54)),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPaymentMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a payment method"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (selectedPaymentMethod == 'card') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailsPage(totalAmount: total),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order Confirmed! 🎉"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B4BDB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
