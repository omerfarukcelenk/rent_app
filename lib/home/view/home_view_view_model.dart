import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rent_app/home/core/network/project_network_manager.dart';
import 'package:rent_app/home/model/home_model.dart';
import 'home.dart';

abstract class HomeViewViewModel extends State<Home> {
  final Dio dio = ProjectNetworkManager.instance.dio;

  List<ProductModel> models = [];

  void fetchAllData() async {
    final response = await dio.get('/products');

    if (response.statusCode == HttpStatus.ok) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final baseProductModel = BaseResponseProduct.fromJson(data);
        models = baseProductModel.result ?? [];
      } else if (data is List) {
        models = data.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    setState(() {});
  }
}

enum ServicePath { PRODUCTS }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.PRODUCTS:
        return '/products';
    }
  }
}