import 'package:flutter/widgets.dart';

abstract class Constants {
  static double kButtonPadding(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.1;
  static const cardsKey = 'credit_cards';
}
