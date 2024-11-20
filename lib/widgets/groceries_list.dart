import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
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
    );

    if (title != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title!),
          ),
          body: content);
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('title'),
          ),
          body: content);
    }
  }
}
