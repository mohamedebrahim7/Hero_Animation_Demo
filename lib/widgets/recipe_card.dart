import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/recipe.dart';
import '../pages/recipe_detail.dart';
import 'fade_route.dart';
import 'icon_text.dart';
import 'ratings.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      FadeRoute(
        page: RecipeDetail(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RecipeImage(imagePath: recipe.imagePath),
        CardInfo(recipe: recipe),
      ],
    );

    if (isLandscape) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RecipeImage(imagePath: recipe.imagePath),
          SizedBox(
            width: screenWidth / 2,
            child: CardInfo(recipe: recipe),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        _navigateToDetail(context);
      },
      child: Container(
        margin: const EdgeInsets.all(24.0),
        padding: isLandscape ? const EdgeInsets.all(8) : null,
        child: Stack(
          children: <Widget>[
            Background(recipeName: recipe.name),
            content,
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final String recipeName;
  const Background({
    required this.recipeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'background-$recipeName',
      transitionOnUserGestures: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String imagePath;

  const RecipeImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final recipeImageHeight = screenHeight * 0.4;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Hero(
      tag: 'recipe-$imagePath',
      transitionOnUserGestures: true,
      child: Container(
        padding: isLandscape ? null : const EdgeInsets.only(top: 16),
        child: Image.asset(
          imagePath,
          height: recipeImageHeight,
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final Recipe recipe;

  const CardInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    return Container(
      padding: isLandscape ? null : const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            recipe.name,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          const Ratings(value: 4),
          const SizedBox(height: 16.0),
          Text(
            recipe.description,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontStyle: FontStyle.italic, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          const SizedBox(height: 24.0),
          _buildExtra(context),
        ],
      ),
    );
  }

  Widget _buildExtra(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconText(
          icon: FontAwesomeIcons.solidClock,
          text: '10 minutes',
          iconColor: Theme.of(context).primaryColor,
        ),
        IconText(
          icon: FontAwesomeIcons.chartPie,
          text: '2 portions',
          iconColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
