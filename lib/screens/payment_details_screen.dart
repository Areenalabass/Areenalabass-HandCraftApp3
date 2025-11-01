import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class PaymentDetailsPage extends StatefulWidget {
  final double totalAmount;

  const PaymentDetailsPage({super.key, required this.totalAmount});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  String cardType = "visa";
  final TextEditingController cardNumberController = TextEditingController();
  String expirationMonth = "January";
  String expirationYear = "2025";
  final TextEditingController cvnController = TextEditingController();

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  final List<String> years = [
    "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
        backgroundColor: const Color(0xFF5B4BDB),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Card Type*",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Radio<String>(
                  value: "visa",
                  groupValue: cardType,
                  onChanged: (value) {
                    setState(() {
                      cardType = value!;
                    });
                  },
                ),
                const Text("Visa"),
                Radio<String>(
                  value: "mastercard",
                  groupValue: cardType,
                  onChanged: (value) {
                    setState(() {
                      cardType = value!;
                    });
                  },
                ),
                const Text("Mastercard"),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Card Number*",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: expirationMonth,
                    decoration: const InputDecoration(labelText: "Expiration Month*", border: OutlineInputBorder()),
                    items: months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        expirationMonth = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: expirationYear,
                    decoration: const InputDecoration(labelText: "Expiration Year*", border: OutlineInputBorder()),
                    items: years.map((year) {
                      return DropdownMenuItem(value: year, child: Text(year));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        expirationYear = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cvnController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CVN*",
                helperText: "This code is three or four digits printed on the back or front of credit cards",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Your Order",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  "\$${widget.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      backgroundColor: Color(0xFFBEC0F9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentSuccessPage(),
                        ),
                      );
                    },
                    child: const Text("Confirm"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4BDB),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
