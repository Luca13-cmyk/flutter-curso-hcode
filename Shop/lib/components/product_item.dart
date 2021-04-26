import 'package:Shop/providers/product.dart';
import 'package:Shop/providers/products.dart';
import 'package:Shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Produto'),
                          content: Text('Tem certeza?'),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não')),
                            FlatButton(
                                onPressed: () {
                                  Provider.of<Products>(context, listen: false)
                                      .deleteProduct(product.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim'))
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
