import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final total = state.cart.fold<double>(0.0, (sum, s) => sum + s.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Carteira')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined),
              title: const Text('Saldo'),
              subtitle: Text('R\$ ${state.walletBalance.toStringAsFixed(2)}'),
              trailing: FilledButton(
                onPressed: () => state.addFunds(100),
                child: const Text('+ R\$ 100'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Carrinho (total R\$ ${total.toStringAsFixed(2)})', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...state.cart.map((s) => Card(
            child: ListTile(
              title: Text('${s.weapon} | ${s.name}'),
              subtitle: Text('R\$ ${s.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                tooltip: 'Remover',
                icon: const Icon(Icons.delete_outline),
                onPressed: () => state.removeFromCart(s),
              ),
            ),
          )),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: state.cart.isEmpty ? null : () {
              final ok = state.purchaseCart();
              final snack = SnackBar(content: Text(ok ? 'Compra efetuada!' : 'Saldo insuficiente.'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
            icon: const Icon(Icons.payment),
            label: const Text('Finalizar compra'),
          ),
          const SizedBox(height: 16),
          Text('Transações', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...state.txLog.reversed.map((t) => ListTile(leading: const Icon(Icons.receipt_long), title: Text(t))),
        ],
      ),
    );
  }
}
