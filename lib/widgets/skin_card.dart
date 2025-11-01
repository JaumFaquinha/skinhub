import 'package:flutter/material.dart';
import '../models/skin.dart';

class SkinCard extends StatelessWidget {
  final Skin skin;
  final VoidCallback onTap;
  const SkinCard({super.key, required this.skin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: skin.imageAsset.isNotEmpty
                  ? Image.asset(skin.imageAsset, fit: BoxFit.cover)
                  : const FlutterLogo(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${skin.weapon} | ${skin.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(label: Text(skin.rarity)),
                      Text('R\$ ${skin.price.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
