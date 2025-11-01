import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../data/mock_data.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  String? _selectedSkinId;
  final _toUser = TextEditingController();

  @override
  void dispose() {
    _toUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Troca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecione um item para oferecer:'),
            const SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedSkinId,
              items: [
                const DropdownMenuItem(value: null, child: Text('Escolha um item')),
                ...mockSkins.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.weapon} | ${s.name}'))),
              ],
              onChanged: (v) => setState(() => _selectedSkinId = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _toUser,
              decoration: const InputDecoration(labelText: 'Usuário destino (ID/Link Steam)'),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                final skin = mockSkins.firstWhere((s) => s.id == _selectedSkinId, orElse: () => mockSkins.first);
                state.simulateTrade(_toUser.text.isEmpty ? 'steam_user_123' : _toUser.text, skin);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oferta de troca simulada.')));
              },
              icon: const Icon(Icons.send),
              label: const Text('Enviar oferta'),
            ),
          ],
        ),
      ),
    );
  }
}
