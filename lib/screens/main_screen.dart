import 'package:flutter/material.dart';
import 'package:findme/mock_items.dart';
import 'package:findme/widgets/bottom_navigation.dart';
import 'package:findme/screens/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3F51B5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.search, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Me!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  'Itens Encontrados',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                      ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // Ação de navegar para a tela de perfil
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar itens ou local...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: mockItems.length,
        itemBuilder: (context, index) {
          final item = mockItems[index];

          Color tagColor = Colors.grey;
          if (item.status == 'Encontrado') {
            tagColor = const Color(0xFF3F51B5);
          } else if (item.status == 'Entregue') {
            tagColor = Colors.grey;
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: item);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: tagColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  item.status,
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.black54),
                              const SizedBox(width: 4),
                              Text(
                                item.location,
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.inventory, size: 16, color: Color(0xFF3F51B5)),
                              const SizedBox(width: 4),
                              // AQUI ESTÁ A MUDANÇA
                              Expanded(
                                child: Text(
                                  'Disponível em: ${item.pickupLocation}',
                                  style: const TextStyle(color: Color(0xFF3F51B5), fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis, // Opcional: Adiciona reticências se o texto for muito longo
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}