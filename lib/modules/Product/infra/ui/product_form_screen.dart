import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/domain/products_provider.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productArgs = ModalRoute.of(context).settings.arguments as Product;
    if (productArgs != null) {
      _formData.clear();
      _formData['id'] = productArgs.id;
      _formData['title'] = productArgs.title;
      _formData['price'] = productArgs.price;
      _formData['category'] = productArgs.category;
      _formData['description'] = productArgs.description;
      _formData['image'] = productArgs.image;
    }
  }

  void _updateImageUrl() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      if (_formData['id'] == null) {
        productsProvider.addProduct(Product.fromMap(_formData));
      } else {
        final success =
            await productsProvider.updateProduct(Product.fromMap(_formData));
        if (!success) {
          Navigator.of(context).pop();
          return _showAlertDialog();
        }
      }
      Navigator.of(context).pop();
    }
  }

  AlertDialog _showAlertDialog() {
    return AlertDialog(
      content: Text('Erro ao realizar a atualiza????o do produto'),
      actions: [
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formData["title"] ?? "Adicionar produto"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _saveForm(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'T??tulo', filled: true),
                initialValue: _formData['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigat??rio' : null,
                onSaved: (newValue) => _formData['title'] = newValue,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pre??o', filled: true),
                initialValue: _formData['price']?.toString(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_categoryFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigat??rio' : null,
                onSaved: (newValue) =>
                    _formData['price'] = double.tryParse(newValue) ?? 0.0,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Categoria', filled: true),
                initialValue: _formData['category'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _categoryFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigat??rio' : null,
                onSaved: (newValue) => _formData['category'] = newValue,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Descri????o', filled: true),
                initialValue: _formData['description'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigat??rio' : null,
                onSaved: (newValue) => _formData['description'] = newValue,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Imagem',
                        filled: true,
                      ),
                      initialValue: _formData['image'] ??
                          'https://icons-for-free.com/iconfiles/png/512/gallery+image+landscape+mobile+museum+open+line+icon-1320183049020185924.png',
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (newValue) => _formData['image'] = newValue,
                      onFieldSubmitted: (_) {
                        _saveForm(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
