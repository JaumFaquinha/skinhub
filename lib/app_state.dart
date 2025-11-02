import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/skin.dart';

class AppState extends ChangeNotifier {
  final List<Skin> _cart = [];
  double _walletBalance = 1500.00;
  final List<String> _txLog = [];

  List<Skin> get cart => List.unmodifiable(_cart);
  double get walletBalance => _walletBalance;
  List<String> get txLog => List.unmodifiable(_txLog);

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Color _brandSeed = const Color(0xFF1EA7FD);
  Color get brandSeed => _brandSeed;

  void addToCart(Skin s) {
    _cart.add(s);
    notifyListeners();
  }

  void removeFromCart(Skin s) {
    _cart.remove(s);
    notifyListeners();
  }

  bool purchaseCart() {
    final total = _cart.fold<double>(0.0, (sum, s) => sum + s.price);
    if (total <= _walletBalance) {
      _walletBalance -= total;
      _txLog.add(
          'Comprou ${_cart.length} item(ns) por R\$ ${total.toStringAsFixed(2)}');
      _cart.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  void addFunds(double amount) {
    _walletBalance += amount;
    _txLog.add('Adicionou R\$ ${amount.toStringAsFixed(2)}');
    notifyListeners();
  }

  void simulateTrade(String toUser, Skin s) {
    _txLog.add('Oferta de troca enviada para $toUser: ${s.weapon} | ${s.name}');
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setBrandSeed(Color color) {
    _brandSeed = color;
    notifyListeners();
  }
}
