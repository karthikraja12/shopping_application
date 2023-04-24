
import 'package:flutter/material.dart';
import 'package:ocean_task/product_screen/singleton.dart';

import 'categories_select.dart';



class FavoriteScreen extends StatefulWidget {
String? name;
   FavoriteScreen({Key? key,this.name}) : super(key: key);

  @override
  FovoriteViewState createState() => FovoriteViewState();
}

class FovoriteViewState extends State<FavoriteScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Do you want to exit?'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () async{
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>  CategorieScreen(),
                          ),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
            return shouldPop!;
          },
          child: Scaffold(

              appBar: AppBar(

                title: const Text("Cart List",style: TextStyle(
                    color: Colors.white,fontSize: 15
                ),),
                centerTitle: true,
                leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () async {
                },),
              ),
              body: SingleChildScrollView(
                  child:SizedBox(
                      height: MediaQuery.of(context).size.height/1.2,
                      width: double.infinity,
                      child:
                      ListView.builder
                        (
                          itemCount:Singleton.instance.cart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Singleton.instance.cart[index].isSelected==true? Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children:  <Widget>[
                                  ListTile(
                                    leading: Image(image: AssetImage(widget.name=='men'?'assets/images/m1.png':'assets/images/f1.png')),

                                    title: Text(Singleton.instance.cart[index].title!,style: const TextStyle(color:Colors.black),),
                                    subtitle: Text('Price  ${Singleton.instance.cart[index].price}.0',style: const TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
                                    trailing: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          Singleton.instance.cart[index].isSelected=false;
                                        });
                                      },
                                      child: const Icon(Icons.delete,color: Colors.grey,),
                                    ),
                                  ),
                                ],
                              ),
                            ):const SizedBox();
                          }
                      )

                  )
              )
          ),
        ),
      );



  }
}
