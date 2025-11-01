import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'app_state.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/item_detail_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/trade_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: Firebase not initialized to keep frontend-only. Can be added later.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CS2 Skins',
        theme: AppTheme.light(),
        initialRoute: '/',
        routes: {
          '/': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
          '/item': (_) => const ItemDetailScreen(),
          '/wallet': (_) => const WalletScreen(),
          '/trade': (_) => const TradeScreen(),
          '/settings': (_) => const SettingsScreen(),
          '/register': (_) => const RegisterScreen(),
        },
      ),
    );
  }
}
