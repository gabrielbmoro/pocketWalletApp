import 'package:flutter/material.dart';
import 'package:pocketwallet/presentation/strings.dart';

const PETS_CODE = 1;
const SUPER_MARKET_CODE = 2;
const HEALTH_CODE = 3;
const GYM_CODE = 4;
const TRANSPORT_CODE = 5;
const TRAVEL_CODE = 6;
const HOUSE_RENT_CODE = 7;
const INVALID_CODE = -1;

enum ExpenseType {
  PETS,
  SUPER_MARKET,
  HEALTH,
  GYM,
  TRANSPORT,
  TRAVEL,
  HOUSE_RENT
}

ExpenseType getExpenseType(int code) {
  switch (code) {
    case PETS_CODE:
      return ExpenseType.PETS;
    case SUPER_MARKET_CODE:
      return ExpenseType.SUPER_MARKET;
    case HEALTH_CODE:
      return ExpenseType.HEALTH;
    case GYM_CODE:
      return ExpenseType.GYM;
    case TRANSPORT_CODE:
      return ExpenseType.TRANSPORT;
    case TRAVEL_CODE:
      return ExpenseType.TRAVEL;
    case HOUSE_RENT_CODE:
      return ExpenseType.HOUSE_RENT;
    default:
      return null;
  }
}

extension ExpenseTypeExtension on ExpenseType {
  List<ExpenseType> values() {
    return [
      ExpenseType.HEALTH,
      ExpenseType.HOUSE_RENT,
      ExpenseType.SUPER_MARKET,
      ExpenseType.PETS,
      ExpenseType.TRAVEL,
      ExpenseType.TRANSPORT,
      ExpenseType.GYM,
    ];
  }

  String get description {
    switch (this) {
      case ExpenseType.PETS:
        return PETS;
      case ExpenseType.SUPER_MARKET:
        return SUPER_MARKET;
      case ExpenseType.HEALTH:
        return HEALTH;
      case ExpenseType.GYM:
        return GYM;
      case ExpenseType.TRANSPORT:
        return TRANSPORT;
      case ExpenseType.TRAVEL:
        return TRAVEL;
      case ExpenseType.HOUSE_RENT:
        return HOUSE_RENT;
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

  int get code {
    switch (this) {
      case ExpenseType.PETS:
        return PETS_CODE;
      case ExpenseType.SUPER_MARKET:
        return SUPER_MARKET_CODE;
      case ExpenseType.HEALTH:
        return HEALTH_CODE;
      case ExpenseType.GYM:
        return GYM_CODE;
      case ExpenseType.TRANSPORT:
        return TRANSPORT_CODE;
      case ExpenseType.TRAVEL:
        return TRAVEL_CODE;
      case ExpenseType.HOUSE_RENT:
        return HOUSE_RENT_CODE;
      default:
        return INVALID_CODE;
    }
  }
}
