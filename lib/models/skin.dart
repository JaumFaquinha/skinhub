class Skin {
  final String id;
  final String name;
  final String weapon;
  final String rarity;
  final double price;
  final String imageAsset;
  final double wear; // 0.0 - 1.0
  final bool statTrak;

  const Skin({
    required this.id,
    required this.name,
    required this.weapon,
    required this.rarity,
    required this.price,
    required this.imageAsset,
    required this.wear,
    required this.statTrak,
  });
}
