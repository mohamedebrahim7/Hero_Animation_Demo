import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appTitle(context),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 24, 8),
            child: Icon(
              FontAwesomeIcons.heart,
              size: 28,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: PageView(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            children:
                recipes.map((recipe) => RecipeCard(recipe: recipe)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _appTitle(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'FO',
        style: TextStyle(
            fontSize: 36,
            color: Color(0xFFF2AC25),
            fontWeight: FontWeight.w700),
        children: [
          TextSpan(
            text: 'ODer',
            style: TextStyle(
                fontSize: 36, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
