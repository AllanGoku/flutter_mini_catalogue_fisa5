import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../providers/favories.dart';
import '../widgets/item_widget.dart';
import 'favorites_page.dart';
import 'item_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = [
    Item(
      title: 'Ordinateur portable',
      description: 'Un ordinateur portable puissant. Capable de lancer des jeux gourmand en très haute définition. Equipé d\'un processeur rapide et puissant, le dernier Intel I9 12130F de la marque.',
      icon: const Icon(Icons.laptop),
      price: '2999.99 €',
    ),
    Item(
      title: 'Samsung Fold',
      description: 'Nouveau Samsung Fold ! Capable de diviser son écran en deux pour s\'élargir jusqu\'à deux mètres.',
      icon: const Icon(Icons.smartphone),
      price: '3999.99 €',
    ),
  ];

  bool _isCompact = false;
  bool _showOnlyFavorites = false; // Filtre favoris uniquement

  @override
  Widget build(BuildContext context) {
    // Récupère l'état des favoris pour appliquer le filtre
    final favories = context.watch<Favories>();

    // Filtre la liste selon l'état du bouton
    final displayedItems = _showOnlyFavorites
        ? items.where((item) => favories.isFavorite(item)).toList()
        : items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesPage(),
                    ),
                  );
                },
              ),
              if (favories.count > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${favories.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text("Produits", style: Theme.of(context).textTheme.headlineLarge),
            Text(
              "Nombre de produits affichés : ${displayedItems.length}",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Boutons d'affichage (Format + Filtre Favoris)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _isCompact = true;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: _isCompact ? Colors.blueGrey[800] : Colors.blueGrey[200],
                    textColor: _isCompact ? Colors.white : Colors.black87,
                    child: const Text("Compact"),
                  ),
                  const SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _isCompact = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: !_isCompact ? Colors.blueGrey[800] : Colors.blueGrey[200],
                    textColor: !_isCompact ? Colors.white : Colors.black87,
                    child: const Text("Détaillé"),
                  ),
                  const SizedBox(width: 8),

                  // Bouton Filtre Favoris uniquement
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _showOnlyFavorites = !_showOnlyFavorites;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: _showOnlyFavorites ? Colors.red[700] : Colors.blueGrey[200],
                    textColor: _showOnlyFavorites ? Colors.white : Colors.black87,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: _showOnlyFavorites ? Colors.white : Colors.red,
                        ),
                        const SizedBox(width: 6),
                        const Text("Favoris uniquement"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Affichage de la liste d'articles (ou message si vide)
            Expanded(
              child: displayedItems.isEmpty
                  ? Center(
                      child: Text(
                        _showOnlyFavorites
                            ? "Aucun produit en favori."
                            : "Aucun produit disponible.",
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView(
                      children: displayedItems.map((item) {
                        return ItemWidget(
                          item: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailPage(item: item),
                              ),
                            );
                          },
                          isCompact: _isCompact,
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
