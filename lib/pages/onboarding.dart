import 'package:flutter/material.dart';

import 'recipes.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  void _navigateToRecipes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Recipes(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _padWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Image.asset('assets/images/hamburger.png'),
              ),
            ),
            _padWidget(
              child: _appTitle(context),
            ),
            _padWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: _subTitleText(context),
              ),
            ),
            _padWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: navigationButton(context),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Text _subTitleText(BuildContext context) {
    return Text(
      'Get your favorite food and'
      '\ntheir ingredients!!',
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
    );
  }

  Widget navigationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateToRecipes(context);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Let\'s Go',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFFd33946), fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: Theme.of(context).textTheme.headlineMedium?.fontSize,
              color: const Color(0xFFd33946),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appTitle(BuildContext context) {
    return Row(
      children: const [
        Text(
          'FO',
          style: TextStyle(
              fontSize: 36,
              color: Color(0xFFF2AC25),
              fontWeight: FontWeight.w700),
        ),
        Text(
          'ODer',
          style: TextStyle(
              fontSize: 36, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _padWidget({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: child,
    );
  }
}
