class Item {
  final String id;
  final String name;
  final String description;
  final String location;
  final String imageUrl;
  final String status;
  final String pickupLocation;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.pickupLocation,
  });
}

final List<Item> mockItems = [
  Item(
    id: '1',
    name: 'Chave do Carro',
    description: 'Chaveiro azul, com um símbolo da Ford.',
    location: 'Biblioteca',
    imageUrl: 'https://picsum.photos/id/10/200/300',
    status: 'Entregue',
    pickupLocation: 'Portaria Principal',
  ),
  Item(
    id: '2',
    name: 'Fone de Ouvido',
    description: 'Fone de ouvido preto, marca Sony.',
    location: 'Cantina',
    imageUrl: 'https://picsum.photos/id/20/200/300',
    status: 'Encontrado',
    pickupLocation: 'Biblioteca - Balcão',
  ),
  Item(
    id: '3',
    name: 'Livro de Cálculo',
    description: 'Livro com capa amarela, título "Cálculo 1".',
    location: 'Sala de aula 205',
    imageUrl: 'https://picsum.photos/id/30/200/300',
    status: 'Encontrado',
    pickupLocation: 'Secretaria do Bloco B',
  ),
];