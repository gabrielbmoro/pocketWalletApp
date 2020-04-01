import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ExpenseType {
  PETS,
  SUPER_MARKET,
  HEALTH,
  GYM,
  TRANSPORT,
  TRAVEL,
  HOUSE_RENT
}

extension ExpenseTypeExcention on ExpenseType {
  String get description {
    switch (this) {
      case ExpenseType.PETS:
        return 'Animais';
      case ExpenseType.SUPER_MARKET:
        return 'Supermercado';
      case ExpenseType.HEALTH:
        return 'Health';
      case ExpenseType.GYM:
        return 'Gym';
      case ExpenseType.TRANSPORT:
        return 'Transporte';
      case ExpenseType.TRAVEL:
        return 'Travel';
      case ExpenseType.HOUSE_RENT:
        return 'Aluguel';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseType.PETS:
        return Icons.pets;
      case ExpenseType.SUPER_MARKET:
        return Icons.shopping_cart;
      case ExpenseType.HEALTH:
        return Icons.beenhere;
      case ExpenseType.GYM:
        return Icons.directions_run;
      case ExpenseType.TRANSPORT:
        return Icons.directions_bus;
      case ExpenseType.TRAVEL:
        return Icons.flight_takeoff;
      case ExpenseType.HOUSE_RENT:
        return Icons.home;
      default:
        return null;
    }
  }
}
