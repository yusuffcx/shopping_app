import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceryItems = [];
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    List<GroceryItem> _loadedItems = [];
    final url = Uri.https(
        'flutter-prep-c7f95-default-rtdb.firebaseio.com', 'shopping-list.json');
    final resp = await http.get(url);
    print(resp.body);
    final Map<String, dynamic> items = jsonDecode(resp.body);
    print(items);
    for (var item in items.entries) {
      print(item);
      final category = categories.entries.firstWhere((it) {
        return it.value.title == item.value['category'];
      }).value;
      _loadedItems.add(GroceryItem(
          category: category,
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity']));
    }
    setState(() {
      _groceryItems = _loadedItems;
    });
  }

  void _addNewItem() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = _groceryItems.isEmpty
        ? const Center(child: Text('There is no List to display'))
        : ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (context, int index) => InkWell(
              onTap: () {},
              child: Slidable(
                startActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        _groceryItems.removeAt(index);
                      });
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  )
                ]),
                child: ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  title: Text(_groceryItems[index].name),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              ),
            ),
          );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery App'),
          actions: [
            IconButton(
                onPressed: _addNewItem,
                icon: const Icon(Icons.add_circle_rounded))
          ],
        ),
        body: activeWidget);
  }
}
