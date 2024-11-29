import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  var error = '';
  var isLoading = true;
  List<GroceryItem> _groceryItems = [];
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final List<GroceryItem> _loadedItems = [];
    final url = Uri.https(
        'flutter-prep-c7f95-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode >= 400) {
        throw Error();
      }
      final Map<String, dynamic> items = json.decode(response.body);
      for (var item in items.entries) {
        final category = categories.entries
            .firstWhere((it) => item.value['category'] == it.value.title)
            .value;
        // item.value['category']
        _loadedItems.add(GroceryItem(
            category: category,
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity']));
      }
      setState(() {
        _groceryItems = _loadedItems;
        isLoading = false;
      });
    } catch (err) {
      if (_loadedItems.isEmpty) {
        setState(() {
          isLoading = false;
          //error = 'No data in the database.';
        });
        return;
      }
      setState(() {
        isLoading = false;
        error = 'Failed to fetch data. Try again later.';
      });
      return;
    }
  }

  void _addNewItem() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    _loadItems();
  }

  void removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-prep-c7f95-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final resp = await http.delete(url);
    print(resp.statusCode);
    if (resp.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget;
    activeWidget = _groceryItems.isEmpty
        ? const Center(child: Text('There is no List to display'))
        : ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (context, int index) => InkWell(
              onTap: () {},
              child: Dismissible(
                key: ValueKey(_groceryItems[index].id),
                onDismissed: (direction) {
                  setState(() {
                    removeItem(_groceryItems[index]);
                  });
                },
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
    if (error != '') {
      activeWidget = Center(child: Text(error));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery App'),
          actions: [
            IconButton(
                onPressed: _addNewItem,
                icon: const Icon(Icons.add_circle_rounded))
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : activeWidget);
  }
}
