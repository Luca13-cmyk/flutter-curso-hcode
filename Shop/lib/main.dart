import 'package:Shop/providers/cart.dart';
import 'package:Shop/providers/products.dart';
import 'package:Shop/providers/orders.dart';
import 'package:Shop/views/cart_screen.dart';
import 'package:Shop/views/orders_screen.dart';
import 'package:Shop/views/product_form_screen.dart';
import 'package:Shop/views/products_overview_screen.dart';
import 'package:Shop/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils/app_routes.dart';
import './views/product_detail_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => new Products(),
            ),
            ChangeNotifierProvider(
              create: (_) => new Cart(),
            ),
            ChangeNotifierProvider(
              create: (_) => new Orders(),
            ),
          ],
          child: MaterialApp(
          title: 'Minha Loja',
          theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          ),
          // home: ProductsOverviewScreen(),
          routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
          },
        ),
    );
  }
}
