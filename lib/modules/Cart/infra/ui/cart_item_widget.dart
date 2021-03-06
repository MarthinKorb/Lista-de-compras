import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_item.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({@required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cartProvider.removeItem(cartItem.productId),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text('Tem certeza?'),
              ],
            ),
            content: Text('Quer remover o item ${cartItem.title} do carrinho?'),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).errorColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${cartItem.title} removido do carrinho.'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(
                    'Sim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: Text('R\$ ${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
            trailing: Text(
              '${cartItem.quantity}x',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
