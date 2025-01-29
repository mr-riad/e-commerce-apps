import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_apps/const/AppColors.dart';
import 'package:e_commerce_apps/pages/product_details_screen.dart';
import 'package:e_commerce_apps/pages/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  double _dotPosition = 0.0;
  List _products = [];
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      _carouselImages = qn.docs.map((doc) => doc["img-path"] as String).toList();
    });
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      _products = qn.docs
          .map((doc) => {
        "product-name": doc["product-name"],
        "product-description": doc["product-description"],
        "product-price": doc["product-price"],
        "product-img": doc["product-img"],
      })
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCarouselImages();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Search products here",
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
                onTap: () => Navigator.push(
                    context, CupertinoPageRoute(builder: (_) => SearchScreen())),
              ),
            ),
            SizedBox(height: 10.h),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                items: _carouselImages
                    .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.fitWidth)),
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, _) {
                      setState(() {
                        _dotPosition = val.toDouble();
                      });
                    }),
              ),
            ),
            SizedBox(height: 10.h),
            DotsIndicator(
              dotsCount: _carouselImages.isEmpty ? 1 : _carouselImages.length,
              position: _dotPosition.toInt(), // Fix: Convert double to int
              decorator: DotsDecorator(
                activeColor: AppColors.deep_orange,
                color: AppColors.deep_orange.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetails(_products[index]))),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 2,
                            child: Container(
                              color: Colors.yellow,
                              child: Image.network(
                                _products[index]["product-img"][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("${_products[index]["product-name"]}"),
                          Text("${_products[index]["product-price"].toString()}"),
                        ],
                      ),
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
