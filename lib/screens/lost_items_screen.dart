import 'package:findme/screens/items_details_screen.dart';
import 'package:findme/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:findme/model/lost_item.dart';
import 'package:findme/screens/register_lost_item_screen.dart';
import 'package:findme/widgets/bottom_navigation.dart';

final mockLostItems = [
  LostItem(
    id: 6,
    name: "Mochila Jansport Azul",
    location: "Corredor Bloco B",
    image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300&h=300&fit=crop",
    description: "Mochila azul com livros de engenharia dentro"
  ),
  LostItem(
    id: 7,
    name: "Celular Samsung Galaxy",
    location: "Laboratório de Informática",
    image: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300&h=300&fit=crop",
    description: "Galaxy S21 com capa transparente e pop socket"
  ),
  LostItem(
    id: 8,
    name: "Relógio Casio",
    location: "Quadra de Esportes",
    image: "https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=300&h=300&fit=crop",
    description: "Relógio digital preto com pulseira de borracha"
  )
];

class LostItemsScreen extends StatefulWidget {
  const LostItemsScreen({Key? key}) : super(key: key);

  @override
  _LostItemsScreenState createState() => _LostItemsScreenState();
}

class _LostItemsScreenState extends State<LostItemsScreen> {
  late List<LostItem> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = mockLostItems;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = mockLostItems.where((item) {
        final itemName = item.name.toLowerCase();
        final itemLocation = item.location.toLowerCase();
        return itemName.contains(query) || itemLocation.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho e Busca
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: [
                  _Header(),
                  const SizedBox(height: 16),
                  _SearchBar(controller: _searchController),
                ],
              ),
            ),
            // Lista de Itens
            Expanded(
              child: _filteredItems.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return _ItemCard(item: _filteredItems[index]);
                      },
                    )
                  : const _EmptyState(),
            ),
          ],
        ),
      ),
      // Botão Flutuante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterLostItemScreen()),
        );
      },
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 1),
    );
  }
}


class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.search, color: Colors.red),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Perdidos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Itens em busca', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          },
          icon: const Icon(Icons.person_outline, color: Colors.grey),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _SearchBar({required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Buscar itens perdidos...',
        prefixIcon: const Icon(Icons.search, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final LostItem item;
  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(item: item),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12), // Para o efeito de splash seguir a borda do card
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[300]!),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      item.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(item.location, style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(item.description, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Perdido',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Nenhum item encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Tente um termo de busca diferente.',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}