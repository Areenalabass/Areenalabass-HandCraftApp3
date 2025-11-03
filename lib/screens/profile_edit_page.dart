import 'package:flutter/material.dart';
import 'package:handcrafts/screens/product_screen.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController nameController = TextEditingController(text: "Areen Alabass");
  TextEditingController addressController = TextEditingController(text: "Mafraq, Jordan");
  TextEditingController emailController = TextEditingController(text: "areen.alabass@example.com");
  TextEditingController phoneController = TextEditingController(text: "+962 7 1234 5678");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF8FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xFF5A54D2),
                backgroundImage: AssetImage("images/person.png"),
              ),
              SizedBox(height: 12),
              Text(
                nameController.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              Text(
                addressController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 25),
              _buildEditableField("Name", nameController),
              SizedBox(height: 10),
              _buildEditableField("Address", addressController),
              SizedBox(height: 10),
              _buildEditableField("Email", emailController),
              SizedBox(height: 10),
              _buildEditableField("Phone", phoneController),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5A54D2),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Profile Updated!")),
                      );
                    },
                    child: Text(
                      "Edit Now",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      side: BorderSide(color: Colors.grey[400]!, width: 2),
                      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen()),
                      );
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 55,
                      height: 55,
                    ),
                    Text(
                      "HANDICRAFTS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A54D2),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.3),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
