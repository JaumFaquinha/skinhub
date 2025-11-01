import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações do Usuário')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema escuro (mock)'),
            value: _dark,
            onChanged: (v) => setState(() => _dark = v),
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
