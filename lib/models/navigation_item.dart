import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationItem {
  final String title;
  final IconData icon;

  NavigationItem({
    required this.title,
    required this.icon,
  });
}

List<NavigationItem> navItems = [
  NavigationItem(title: 'Recipes', icon: FontAwesomeIcons.cheese),
  NavigationItem(title: 'Favourite', icon: FontAwesomeIcons.solidHeart),
  NavigationItem(title: 'News', icon: FontAwesomeIcons.solidNewspaper),
  NavigationItem(title: 'Shoplist', icon: FontAwesomeIcons.basketShopping),
  NavigationItem(title: 'Profile', icon: FontAwesomeIcons.userLarge),
];
