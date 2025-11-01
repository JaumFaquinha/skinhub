import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/skin.dart';
import '../app_state.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Skin skin = ModalRoute.of(context)!.settings.arguments as Skin;
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: Text('${skin.weapon} | ${skin.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: skin.imageAsset.isNotEmpty
                ? Image.asset(skin.imageAsset, fit: BoxFit.cover)
                : const FlutterLogo(),
          ),
          const SizedBox(height: 16),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              Chip(label: Text('Raridade: ${skin.rarity}')),
              Chip(label: Text('Float: ${skin.wear.toStringAsFixed(2)}')),
              Chip(label: Text(skin.statTrak ? 'StatTrak' : 'Sem StatTrak')),
            ],
          ),
          const SizedBox(height: 16),
          Text('R\$ ${skin.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => state.addToCart(skin),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Adicionar ao carrinho'),
          ),
        ],
      ),
    );
  }
}
