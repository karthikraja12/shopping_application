import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ocean_task/product_screen/product.dart';
import 'package:ocean_task/product_screen/singleton.dart';
import '../model/product_model.dart';

class CategorieScreen extends StatefulWidget {
  CategorieScreen({Key? key}) : super(key: key);

  @override
  CategoriesviewState createState() => CategoriesviewState();
}

class CategoriesviewState extends State<CategorieScreen> {
  List<Data> productList = [];
  List<Data> productList2 = [];
  List<Data> productList3 = [];
  bool isLoading = true;
  int selectedNavBarIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedNavBarIndex = index;
    });
  }

  @override
  void initState() {
    getProductDetails();
    super.initState();
  }

  Future<dynamic> getProductDetails() async {
    await Dio().get('https://api.storerestapi.com/products').then((value) {
      if (value.statusCode == 200) {
        productList = ProductList.fromJson(value.data).data!;
        print('product list:');
        print(productList[0].category!.name);
      } else {
        Fluttertoast.showToast(
            msg: "Please check your internet ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: const Text('Online Shop',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
                semanticsLabel: '',
                color: Colors.white,
              ),
            )
          : Container(
        width: MediaQuery.of(context).size.height / 1,
              padding: const EdgeInsets.only(left:8.0,top: 0.5,bottom: 8.0,right: 8.0),
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  )
              ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Categories',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        final mensData = productList.where(
                            (element) => element.slug != 'womens-fashion');
                        Singleton.instance.cart.addAll(mensData);
                        if (mensData.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                        productList1: mensData.toList(),name: 'men',
                                      )));
                        } else {
                          Fluttertoast.showToast(
                              msg: "No data ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 1),
                            Text('Men\'s fashion',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                            SizedBox(
                                height: 150,
                                width: 150,
                                child: Image(
                                    image: AssetImage('assets/images/mens.jpeg'))),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        productList.forEach((element) async {
                          if (element.category!.slug != 'mens-fashion') {
                            productList2.add(element);
                            Singleton.instance.cart.add(element);
                            if (productList2.isNotEmpty) {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                            productList1: productList2,name:'women',
                                          )));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "No data ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 1),
                            Text('women\'s fashion',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                            SizedBox(
                                height: 150,
                                width: 150,
                                child: Image(
                                    image: AssetImage('assets/images/womens.png'))),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        productList.forEach((element) async {
                          if (element.category!.slug == 'bags-and-shoes') {
                            productList3.add(element);
                            Singleton.instance.cart.add(element);
                            if (productList3.isNotEmpty) {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                            productList1: productList3,name:'bags',
                                          )));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "No data ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 1),
                            Text('bags & shoes',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                            SizedBox(
                                height: 150,
                                width: 150,
                                child: Image(
                                    image: AssetImage('assets/images/bags_shoes.jpeg'))),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60,),
                  ],
                ),
            ),
          ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme:
        IconThemeData(color: Colors.black54, size: 30),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ''),
        ],
       currentIndex: selectedNavBarIndex,
        //selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,

        //  onTap: _onItemTapped,
      ),
    );
  }



}
