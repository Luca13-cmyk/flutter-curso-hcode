import 'package:Meal/components/main_drawer.dart';
import 'package:Meal/screens/categories_screen.dart';
import 'package:Meal/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedSreenIndex = 0;

  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
    {'title':  'Lista de Categorias', 'screen':  CategoriesScreen()},
    {'title': 'Meus Favoritos', 'screen': FavoriteScreen(widget.favoriteMeals)}
    ];

  }

  _selectScreen(int index) {
    setState(() {
      _selectedSreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedSreenIndex]['title']),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedSreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedSreenIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categorias'
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favoritos'
          )
        ]
      ),
    );
  }
}