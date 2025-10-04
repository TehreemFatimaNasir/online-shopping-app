import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProductsPage(),
    );
  } 
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, String>> cart = [];

  final List<Map<String, String>> products = [
    {"image": "assets/images/OIP.jpeg", "title": "IVY POUR FEMME", "price": "Rs. 4,800"},
    {"image": "assets/images/per2.jpeg", "title": "RUMI POUR HOMME", "price": "Rs. 5,000"},
    {"image": "assets/images/per3.jpg", "title": "VERSACE POUR HOMME", "price": "Rs. 5,500"},
    {"image": "assets/images/per4.jpeg", "title": "UKIYO POUR HOMME", "price": "Rs. 6,000"},
    {"image": "assets/images/per7.jpg", "title": "Gucci flora", "price": "Rs. 8,000"},
    {"image": "assets/images/per9.jpg", "title": "Gucci flora", "price": "Rs. 8,000"},
    {"image": "assets/images/per8.jpg", "title": "flora by Gucci", "price": "Rs. 10,000"},
    {"image": "assets/images/per10.jpg", "title": "SAPPHIRE", "price": "Rs. 10,000"},
    {"image": "assets/images/per11.jpg", "title": "OUD VIBRANT BY ZARA", "price": "Rs. 10,000"},
    {"image": "assets/images/per12.jpg", "title": "KHAADI MORNING SPARKLE", "price": "Rs. 15,000"},
    {"image": "assets/images/per13.jpg", "title": "KHAADI KHASS OUD", "price": "Rs. 17,000"},
    {"image": "assets/images/per14.jpg", "title": "KHAADI GOLDEN HAZE", "price": "Rs. 20,000"},
  ];

  Widget productCard(BuildContext context, Map<String, String> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            product["image"] ?? "",
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          product["title"] ?? "", 
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          product["price"] ?? "",
          style: const TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB8D8D8),
              foregroundColor: const Color(0xFF333333), 
            ),
            child: const Text("BUY NOW"),
            onPressed: () {
              setState(() {
                cart.add(product);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB8D8D8),
        elevation: 4,
        iconTheme: const IconThemeData(color: Color(0xFF333333)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage("assets/images/Cologne Shop.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => productCard(context, products[index]),
                childCount: products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.63,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cart;
  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CART",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFFB8D8D8),
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Image.asset(
                      widget.cart.last["image"] ?? "",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return ListTile(
                        leading: Image.asset(item["image"] ?? "", width: 50, height: 50),
                        title: Text(item["title"] ?? ""),
                        subtitle: Text(item["price"] ?? ""),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.cart.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Proceed to Checkout"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CheckoutPage()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHECKOUT",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFFB8D8D8),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.teal,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                "Thank you for your purchase!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Your order has been placed successfully",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductsPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
