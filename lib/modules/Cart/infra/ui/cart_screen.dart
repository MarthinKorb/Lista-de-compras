import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Cart/infra/ui/cart_item_widget.dart';
import 'package:lista_de_compras/modules/Order/domain/orders_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final OrdersProvider ordersProvider =
        Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: cartProvider.isCartEmpty()
                ? EmptyCartIWarning()
                : ListView.builder(
                    itemCount: cartProvider.itemCount,
                    itemBuilder: (context, index) {
                      return CartItemWidget(cartItem: cartItems[index]);
                    },
                  ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    elevation: 4,
                    label: Text(
                      'R\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          child: Text(
                            'Confirmar Lista',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (!cartProvider.isCartEmpty()) {
                              ordersProvider.addOrder(cart: cartProvider);
                              cartProvider.clearCart();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => Container(
                                  child: AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outlined,
                                          size: 30,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Aviso',
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      'Não é possível efetuar uma compra sem pelo menos um item no carrinho.',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyCartIWarning extends StatelessWidget {
  const EmptyCartIWarning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/groceries.png",
          width: 100,
        ),
        SizedBox(height: 16),
        Text(
          'Sua lista está vazia...',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Adicione itens à sua lista de compras...',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
