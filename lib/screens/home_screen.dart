import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/skin.dart';
import '../widgets/skin_card.dart';
import '../widgets/filter_panel.dart';
import '../app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FilterValues _filters = const FilterValues();

  List<Skin> _applyFilters(List<Skin> src) {
    return src.where((s) {
      if (_filters.query.isNotEmpty) {
        final q = _filters.query.toLowerCase();
        final hay = '${s.weapon} ${s.name}'.toLowerCase();
        if (!hay.contains(q)) return false;
      }
      if (_filters.rarity != 'Todas' && s.rarity != _filters.rarity) return false;
      if (_filters.onlyStatTrak && !s.statTrak) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final filtered = _applyFilters(mockSkins);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja de Skins'),
        actions: [
          IconButton(
            tooltip: 'Filtros',
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => FilterPanel(initial: _filters, onApply: (v) => setState(() => _filters = v)),
              );
            },
            icon: const Icon(Icons.tune),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                tooltip: 'Carrinho',
                onPressed: () => Navigator.pushNamed(context, '/wallet'),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (state.cart.isNotEmpty)
                CircleAvatar(
                  radius: 9,
                  child: Text('${state.cart.length}', style: const TextStyle(fontSize: 12)),
                ),
            ],
          ),
          IconButton(
            tooltip: 'Menu do Usuário',
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => _UserMenu(),
            ),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, c) {
            final cross = c.maxWidth > 1100 ? 5 : c.maxWidth > 800 ? 4 : c.maxWidth > 600 ? 3 : 2;
            return GridView.builder(
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cross, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.72,
              ),
              itemBuilder: (_, i) {
                final s = filtered[i];
                return SkinCard(
                  skin: s,
                  onTap: () => Navigator.pushNamed(context, '/item', arguments: s),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) Navigator.pushNamed(context, '/trade');
          if (i == 2) Navigator.pushNamed(context, '/settings');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Comprar'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Troca'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ],
      ),
    );
  }
}

class _UserMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Carteira'),
            onTap: () => Navigator.pushNamed(context, '/wallet'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}
