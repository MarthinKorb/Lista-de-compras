import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: product.id, child: ImageSession(product: product)),
            SizedBox(height: 10),
            CategorySection(product: product),
            DescriptionHeader(),
            DescriptionSection(product: product),
            PriceSection(product: product),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green[50],
      ),
      child: Text(
        'Categoria : ${product.category}',
        style: TextStyle(
          color: Colors.black45,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PriceSection extends StatelessWidget {
  const PriceSection({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'R\$ ${product.price}',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 18,
            ),
            child: Text(
              '${product.description}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionHeader extends StatelessWidget {
  const DescriptionHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Descrição',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageSession extends StatelessWidget {
  const ImageSession({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      color: Colors.white,
      width: double.infinity,
      child: Image.network(
        product.image,
        fit: BoxFit.contain,
      ),
      // : Image.asset(
      //     product.image,
      //     fit: BoxFit.contain,
      //   ),
    );
  }
}
