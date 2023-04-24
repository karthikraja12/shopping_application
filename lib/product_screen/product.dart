
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import 'favorite.dart';

class ProductScreen extends StatefulWidget {
  List<Data>? productList1;
  String? name;
   ProductScreen({Key? key,this.productList1,this.name}) : super(key: key);

  @override
  ProductState createState() => ProductState();
}

class ProductState extends State<ProductScreen> {
  int selectedNavBarIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedNavBarIndex = index;
    });
  }
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Product',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, size: 30, color: Colors.orange)
            ),
            elevation: 0,
          ),
          body: Container(
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
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraint) {
                  return GestureDetector(
                    onTap: () {
                      final FocusScopeNode currentFocus =
                      FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1,
                            width: double.infinity,
                            child: GridView.builder(
                              physics: const ScrollPhysics(),
                              itemCount:widget.productList1!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1.4 / 2),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                              itemBuilder: (
                                  context,
                                  index,
                                  ) {
                                return Card(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (widget.productList1![index].isSelected==
                                                        false) {
                                                      widget.productList1![index].isSelected = true;
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  widget.productList1![index].isSelected==
                                                      true
                                                      ? Icons.favorite_border :Icons.favorite,        //shopping_cart,
                                                  color: widget.productList1![index].isSelected==
                                                      true
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ))),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    8.4,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    3,
                                                color: Colors.white,
                                                child:
                                                Image(image: AssetImage(widget.name=='men'?'assets/images/mens.jpeg': widget.name=='women'?'assets/images/womens.png' : 'assets/images/bags_shoes.jpeg')),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                widget.productList1![index].title!,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.fade,
                                                style:
                                                const TextStyle(fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ), Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Price:${widget.productList1![index].price!}.0',style: TextStyle(color:Colors.black,fontSize:14, fontWeight: FontWeight.bold)),
                                                  Icon(Icons.shopping_cart, size: 22,color: Colors.grey)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ));
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
             await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FavoriteScreen(name:widget.name,)));
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
          ),
        )
      );



  }
}
