import 'package:flutter/material.dart';
import '../model/product_model.dart';



class Singleton {
  factory Singleton() {
    return instance;
  }

  Singleton.internal();

  static final Singleton instance = Singleton.internal();

  BuildContext? buildContext;

  List <Data> cart = [];

}