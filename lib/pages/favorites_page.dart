import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favories.dart';
import '../widgets/item_widget.dart';
import 'item_detail_page.dart';

/// Page dédiée à l'affichage des favoris
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favories = context.watch<Favories>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Mes Favoris"),
      ),
      body: favories.items.isEmpty
          ? const Center(
              child: Text(
                "Aucun favori pour le moment.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favories.items.length,
              itemBuilder: (context, index) {
                final item = favories.items[index];
                return ItemWidget(
                  item: item,
                  onTap: () {
                    // Redirection vers la fiche détaillée du produit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(item: item),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
