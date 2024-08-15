import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/navigation_item.dart';
import '../models/recipe.dart';
import '../widgets/icon_text.dart';
import '../widgets/ratings.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.title,
                ))
            .toList(),
        currentIndex: 0,
        backgroundColor: const Color(0xFFf0efed),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      // A fixed-height child.
                      height: 200,
                      child: Header(recipe: recipe),
                    ),
                    Expanded(
                      // A flexible child that will grow to fit the viewport but
                      // still be at least as big as necessary to fit its contents.
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          HeroBackground(recipe: recipe),
                          Column(
                            children: <Widget>[
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -30.0, 0.0),
                                child: HeroRecipeImage(
                                  imagePath: recipe.imagePath,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  IngredientList(
                                    ingredients: recipe.ingredients,
                                  ),
                                  // Other contents can be added here
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
      child: Column(
        children: <Widget>[
          Text(
            recipe.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          const Ratings(
            value: 4,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                IconText(
                  icon: FontAwesomeIcons.solidClock,
                  text: '10 minutes',
                  iconColor: Colors.white,
                  fontColor: Colors.white,
                ),
                IconText(
                  icon: FontAwesomeIcons.chartPie,
                  text: '2 portions',
                  iconColor: Colors.white,
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroRecipeImage extends StatelessWidget {
  const HeroRecipeImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final recipeImageHeight = screenHeight * 0.25;
    return Hero(
      tag: 'recipe-$imagePath',
      transitionOnUserGestures: true,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final toHero = toHeroContext.widget;
        return RotationTransition(
          turns: animation,
          child: toHero,
        );
      },
      child: Image.asset(
        imagePath,
        height: recipeImageHeight,
      ),
    );
  }
}

class HeroBackground extends StatelessWidget {
  const HeroBackground({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'background-${recipe.name}',
      transitionOnUserGestures: true,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final borderAnimation = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(0.0),
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
        );
        return AnimatedBuilder(
            animation: borderAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: borderAnimation.value,
                  color: Colors.white,
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  const IngredientList({
    super.key,
    required this.ingredients,
  });

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: (screenWidth / 2) - 1,
          child: Container(
            transform: Matrix4.translationValues(0, -30, 0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black26, width: 2),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: ingredients.map((ingredient) {
              return IngredientRow(
                ingredient: ingredient,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class IngredientRow extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientRow({super.key, required this.ingredient});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              ingredient.quantity,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          ClipOval(
            child: Image.asset(
              ingredient.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                ingredient.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
