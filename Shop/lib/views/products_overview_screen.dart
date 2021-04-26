import 'package:Shop/components/app_drawer.dart';
import 'package:Shop/components/product_grid.dart';
import 'package:Shop/providers/cart.dart';
import 'package:Shop/providers/products.dart';
import 'package:Shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/badge.dart';
// import 'package:provider/provider.dart';
// import '../providers/products.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Products products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorite) {
                    // products.showFavoriteOnly();
                    _showFavoriteOnly = true;
                  } else {
                    // products.showAll();
                    _showFavoriteOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                      child: Text('Somente Favoritos'),
                      value: FilterOptions.Favorite),
                  PopupMenuItem(child: Text('Todos'), value: FilterOptions.All),
                ];
              }),
          Consumer<Cart>(
            child: IconButton(
              // n sofre alteracao
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CART,
                );
              },
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
