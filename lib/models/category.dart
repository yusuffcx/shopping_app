import 'dart:ui';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category {
  const Category(this.title, this.color);
  final String title;
  final Color color;
  //final Map<Categories, Category> categories;
}
