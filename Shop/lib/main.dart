import 'package:Shop/providers/auth.dart';
import 'package:Shop/providers/cart.dart';
import 'package:Shop/providers/products.dart';
import 'package:Shop/providers/orders.dart';
// import './views/auth_screen.dart';
import 'package:Shop/views/cart_screen.dart';
import 'package:Shop/views/auth_home_screen.dart';
import 'package:Shop/views/orders_screen.dart';
import 'package:Shop/views/product_form_screen.dart';
// import 'package:Shop/views/products_overview_screen.dart';
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
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => new Products(),
          update: (ctx, auth, previousProducts) =>
              new Products(auth.token, auth.userId, previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => new Orders(),
          update: (ctx, auth, previousOrders) =>
              new Orders(auth.token, auth.userId, previousOrders.items),
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
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
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
