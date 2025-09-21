import 'package:flutter/material.dart';


class RegisterSectorScreen extends StatefulWidget {
  const RegisterSectorScreen({Key? key}) : super(key: key);

  @override
  _RegisterSectorScreenState createState() => _RegisterSectorScreenState();
}

class _RegisterSectorScreenState extends State<RegisterSectorScreen> {
  
  final _formKey = GlobalKey<FormState>();

  
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _availableHoursController = TextEditingController();

  @override
  void dispose() {
    
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _availableHoursController.dispose();
    super.dispose();
  }

  void _submitForm() {
    
    if (_formKey.currentState!.validate()) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setor cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Cadastrar Setor', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Nome do Setor *',
                hintText: 'Ex: Portaria Bloco A, Secretaria, etc.',
                icon: Icons.location_on_outlined,
                isRequired: true,
              ),
              _buildTextField(
                controller: _locationController,
                labelText: 'Localização *',
                hintText: 'Ex: Térreo do Bloco Principal',
                isRequired: true,
              ),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Descrição/Instruções',
                hintText: 'Ex: Falar com o segurança João, levar documento...',
                maxLines: 4,
              ),
              _buildTextField(
                controller: _contactNameController,
                labelText: 'Pessoa de Contato *',
                hintText: 'Nome da pessoa responsável',
                icon: Icons.person_outline,
                isRequired: true,
              ),
              _buildTextField(
                controller: _contactPhoneController,
                labelText: 'Telefone de Contato',
                hintText: 'Ex: (11) 99999-9999',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _availableHoursController,
                labelText: 'Horário de Funcionamento',
                hintText: 'Ex: 8h às 18h, Segunda a Sexta',
                icon: Icons.access_time_outlined,
              ),
              const SizedBox(height: 24),
              _buildInfoBox(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Cadastrar Setor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    IconData? icon,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) Icon(icon, color: Colors.blue, size: 18),
              if (icon != null) const SizedBox(width: 8),
              Text(labelText, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Este campo é obrigatório.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          children: const [
            TextSpan(
              text: 'Importante: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'Este setor ficará disponível para pessoas que encontrarem itens deixarem os objetos para que os donos possam recuperá-los.',
            ),
          ],
        ),
      ),
    );
  }
}