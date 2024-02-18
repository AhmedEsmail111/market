import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/home/home_cubit.dart';
import 'package:shop_app/controller/home/home_states.dart';
import 'package:shop_app/modules/products/products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      final cubit = HomeCubit.get(context);
      return Scaffold(
        // if loading data is finished ,show the screen
        body: !cubit.isLoading
            ? BuildProducts()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
