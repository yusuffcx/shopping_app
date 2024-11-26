import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  final List<GroceryItem> _groceryItems = [];

  void _addNewItem() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    /*.then((value) {
      setState(() {
        _groceryItems.add(value);
      });
    });*/
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
