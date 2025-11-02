import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = false;
  bool _biometric = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações do Usuário')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema escuro'),
            value: state.themeMode == ThemeMode.dark,
            onChanged: (v) =>
                state.setThemeMode(v ? ThemeMode.dark : ThemeMode.light),
          ),
          ListTile(
            title: const Text('Cor principal (Seed)'),
            subtitle: Text(
                '#${state.brandSeed.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}'),
            trailing: FilledButton(
              onPressed: () async {
                // Exemplo simples: rotaciona entre algumas cores
                final palette = <Color>[
                  const Color(0xFF1EA7FD), // azul
                  const Color(0xFF7C3AED), // roxo
                  const Color(0xFF10B981), // verde
                  const Color(0xFFF59E0B), // âmbar
                  const Color(0xFFEF4444), // vermelho
                ];
                final idx =
                    (palette.indexOf(state.brandSeed) + 1) % palette.length;
                state.setBrandSeed(palette[idx]);
              },
              child: const Text('Trocar cor'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'As mudanças de cor afetam todo o esquema (primária, secundária, etc.) via ColorScheme.fromSeed.'),
          ),
          SwitchListTile(
            title: const Text('Biometria (mock)'),
            value: _biometric,
            onChanged: (v) => setState(() => _biometric = v),
          ),
          SwitchListTile(
            title: const Text('Notificações (mock)'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          const ListTile(
            title: Text('Privacidade e Proteção de Dados'),
            subtitle: Text('Configurações demonstrativas — sem backend.'),
          ),
        ],
      ),
    );
  }
}
