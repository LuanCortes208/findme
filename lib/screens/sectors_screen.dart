import 'package:flutter/material.dart';
import 'package:findme/screens/register_sector_screen.dart';
import 'package:findme/widgets/bottom_navigation.dart';


class Sector {
  final int id;
  final String name;
  final String description;
  final String contactName;
  final String contactPhone;
  final String availableHours;
  final String location;

  Sector({
    required this.id,
    required this.name,
    required this.description,
    required this.contactName,
    required this.contactPhone,
    required this.availableHours,
    required this.location,
  });
}


final mockSectors = [
  Sector(
    id: 1,
    name: "Portaria Bloco A",
    description: "Falar com o segurança João. Disponível 24h.",
    contactName: "João Silva",
    contactPhone: "(11) 99999-0001",
    availableHours: "24 horas",
    location: "Entrada principal do Bloco A"
  ),
  Sector(
    id: 2,
    name: "Secretaria Acadêmica",
    description: "Atendimento no balcão da secretaria. Levar documento.",
    contactName: "Maria Santos",
    contactPhone: "(11) 99999-0002",
    availableHours: "8h às 17h - Segunda a Sexta",
    location: "Térreo do Bloco Principal"
  ),
];


class SectorsScreen extends StatefulWidget {
  const SectorsScreen({Key? key}) : super(key: key);

  @override
  _SectorsScreenState createState() => _SectorsScreenState();
}

class _SectorsScreenState extends State<SectorsScreen> {
  late List<Sector> _filteredSectors;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSectors = mockSectors;
    _searchController.addListener(_filterSectors);
  }

  void _filterSectors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSectors = mockSectors.where((sector) {
        final sectorName = sector.name.toLowerCase();
        final sectorLocation = sector.location.toLowerCase();
        return sectorName.contains(query) || sectorLocation.contains(query);
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
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _Header(),
                  const SizedBox(height: 16),
                  _SearchBar(controller: _searchController),
                ],
              ),
            ),
            
            Expanded(
              child: _filteredSectors.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredSectors.length,
                      itemBuilder: (context, index) {
                        return _SectorCard(sector: _filteredSectors[index]);
                      },
                    )
                  : const _EmptyState(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 2),
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
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.location_on, color: Colors.grey[700]),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Setores', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Locais de recuperação', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterSectorScreen()),
          );
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Novo'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
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
        hintText: 'Buscar setores...',
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

class _SectorCard extends StatelessWidget {
  final Sector sector;
  const _SectorCard({required this.sector});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                
                const Icon(Icons.location_on_outlined, color: Colors.blue),
                const SizedBox(width: 8),
                Text(sector.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(sector.description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            _InfoRow(icon: Icons.person_outline, title: 'Contato:', value: sector.contactName),
            _InfoRow(icon: Icons.phone_outlined, value: sector.contactPhone),
            _InfoRow(icon: Icons.access_time_outlined, value: sector.availableHours),
            _InfoRow(icon: Icons.pin_drop_outlined, value: sector.location, isLocation: true),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String value;
  final bool isLocation;

  const _InfoRow({required this.icon, this.title, required this.value, this.isLocation = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 12),
          if (title != null)
            Text(title!, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (title != null)
            const SizedBox(width: 4),
          Text(value, style: TextStyle(color: isLocation ? Colors.grey[600] : Colors.black87)),
        ],
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
            'Nenhum setor encontrado',
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