import 'package:flutter/material.dart';

class FilterValues {
  final String query;
  final String rarity;
  final bool onlyStatTrak;
  const FilterValues({this.query = '', this.rarity = 'Todas', this.onlyStatTrak = false});

  FilterValues copyWith({String? query, String? rarity, bool? onlyStatTrak}) =>
      FilterValues(
        query: query ?? this.query,
        rarity: rarity ?? this.rarity,
        onlyStatTrak: onlyStatTrak ?? this.onlyStatTrak,
      );
}

class FilterPanel extends StatefulWidget {
  final FilterValues initial;
  final void Function(FilterValues) onApply;
  const FilterPanel({super.key, required this.initial, required this.onApply});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late TextEditingController _q;
  late String _rarity;
  bool _statTrak = false;

  @override
  void initState() {
    super.initState();
    _q = TextEditingController(text: widget.initial.query);
    _rarity = widget.initial.rarity;
    _statTrak = widget.initial.onlyStatTrak;
  }

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rarities = const ['Todas', 'Covert', 'Classified', 'Restricted'];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _q,
            decoration: const InputDecoration(
              labelText: 'Pesquisar (arma/skin)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Raridade:'),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _rarity,
                items: rarities.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (v) => setState(() => _rarity = v ?? 'Todas'),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text('StatTrak'),
                  Switch(value: _statTrak, onChanged: (v) => setState(() => _statTrak = v)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              widget.onApply(FilterValues(query: _q.text, rarity: _rarity, onlyStatTrak: _statTrak));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.tune),
            label: const Text('Aplicar filtros'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
