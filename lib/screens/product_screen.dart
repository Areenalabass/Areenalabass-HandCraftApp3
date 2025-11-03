import 'package:flutter/material.dart';
import '../widgets/handicrafts_drawer.dart';
import 'favourites_page.dart';
import 'product_details.dart';

void main() {
  runApp(const HandicraftsApp());
}

class HandicraftsApp extends StatelessWidget {
  const HandicraftsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handicrafts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "title": "Bracelets black with Custom name",
        "price": 1.5,
        "color": const Color(0xFF5A54D2),
        "image": "images/bracelet.jpg",
        "description": "Beautiful handmade bracelet with your custom name engraved.",
      },
      {
        "title": "Soap with natural olive oil",
        "price": 2.5,
        "color": const Color(0xFF5A54D2),
        "image": "images/soap.jpg",
        "description": "Natural olive oil soap for soft and healthy skin.",
      },
      {
        "title": "Handmade bag",
        "price": 5,
        "color": const Color(0xFF5A54D2),
        "image": "images/bag.jpg",
        "description": "A stylish handmade bag perfect for daily use.",
      },
      {
        "title": "A candle with custom writing on it.",
        "price": 2,
        "color": const Color(0xFF5A54D2),
        "image": "images/candle.jpg",
        "description": "A personalized candle with custom message engraved.",
      },
    ];

    return Scaffold(
      drawer: HandicraftsDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "HANDICRAFTS",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(product: product),
                  ),
                );
              },
              child: ProductCard(
                product: product,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    isFav = FavouritesPage.favouriteItems.any((item) => item['title'] == widget.product['title']);
  }

  void toggleFavorite() {
    setState(() {
      if (isFav) {
        FavouritesPage.favouriteItems.removeWhere((item) => item['title'] == widget.product['title']);
      } else {
        FavouritesPage.favouriteItems.add({
          'title': widget.product['title'],
          'price': '\$${widget.product['price'].toStringAsFixed(2)}',
          'image': widget.product['image'],
          'isFav': true,
          'bgColor': widget.product['color'],
        });
      }
      isFav = !isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5A54D2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    widget.product["image"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  widget.product["title"],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // جعل النص أبيض لتباين مع الخلفية
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product["price"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
