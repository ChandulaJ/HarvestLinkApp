import 'package:flutter/material.dart';

class Item {
  String name;
  String description;
  double price;
  int amount;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.amount,
  });
}

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Item> menuItems = [
    Item(name: 'Carrot', description: 'Carrot', price: 200, amount: 10),
    Item(name: 'Pumpkin', description: 'Pumpkin', price: 300, amount: 15),
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return ListTile(
            title: Text(menuItem.name),
            subtitle: Text(menuItem.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(menuItem, index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteItem(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Food Item'),
          content: _buildForm(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addItem();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Item menuItem, int index) {
    _nameController.text = menuItem.name;
    _descriptionController.text = menuItem.description;
    _priceController.text = menuItem.price.toString();
    _amountController.text = menuItem.amount.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Food Item'),
          content: _buildForm(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editItem(index);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: _priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: 'Price'),
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Amount'),
        ),
      ],
    );
  }

  void _addItem() {
    setState(() {
      menuItems.add(Item(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        amount: int.parse(_amountController.text),
      ));
      _clearControllers();
    });
  }

  void _editItem(int index) {
    setState(() {
      menuItems[index] = Item(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        amount: int.parse(_amountController.text),
      );
      _clearControllers();
    });
  }

  void _deleteItem(int index) {
    setState(() {
      menuItems.removeAt(index);
    });
  }

  void _clearControllers() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _amountController.clear();
  }
}
