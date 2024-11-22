import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key, this.title});
  final String? title;

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  void _addNewItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.title == null
              ? const Text('Grocery App')
              : Text(widget.title!),
          actions: [
            IconButton(
                onPressed: _addNewItem,
                icon: const Icon(Icons.add_circle_rounded))
          ],
        ),
        body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, int index) => InkWell(
            onTap: () {},
            child: ListTile(
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItems[index].category.color,
              ),
              title: Text(groceryItems[index].name),
              trailing: Text(groceryItems[index].quantity.toString()),
            ),
          ),
        ));
  }
}
