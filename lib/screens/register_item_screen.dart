import 'package:flutter/material.dart';

class RegisterItemScreen extends StatelessWidget {
  const RegisterItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Item Encontrado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome do Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Onde foi encontrado?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Descrição detalhada',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação de salvamento (neste projeto, pode ser só um aviso)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item cadastrado com sucesso!')),
                );
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: const Text('Salvar Item'),
            ),
          ],
        ),
      ),
    );
  }
}