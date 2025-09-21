import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class RegisterLostItemScreen extends StatefulWidget {
  const RegisterLostItemScreen({Key? key}) : super(key: key);

  @override
  _RegisterLostItemScreenState createState() => _RegisterLostItemScreenState();
}

class _RegisterLostItemScreenState extends State<RegisterLostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  
  
  final _itemNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  
  File? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _itemNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item perdido registrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Perdido'),
            Text('Registrar item que você perdeu', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Registrar Item Perdido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _itemNameController,
                    labelText: 'O que perdeu?',
                    hintText: 'Ex: iPhone, chaves, carteira...',
                    isRequired: true,
                  ),
                  _buildTextField(
                    controller: _locationController,
                    labelText: 'Onde perdeu?',
                    hintText: 'Ex: Biblioteca, Cantina, Bloco A...',
                    isRequired: true,
                  ),
                  _buildTextField(
                    controller: _descriptionController,
                    labelText: 'Descrição (opcional)',
                    hintText: 'Descreva o item com mais detalhes...',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  const Text('Foto do Item (opcional)', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  _buildImagePicker(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : const Text('Salvar Item Perdido'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String labelText, required String hintText, bool isRequired = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildImagePicker() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: Colors.grey[400]!,
      strokeWidth: 1,
      dashPattern: const [6, 6],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: _image != null
            ? Column(
                children: [
                  Image.file(_image!, height: 128, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => setState(() => _image = null),
                    child: const Text('Remover foto'),
                  ),
                ],
              )
            : Column(
                children: [
                  Icon(Icons.camera_alt_outlined, size: 48, color: Colors.grey[500]),
                  const SizedBox(height: 16),
                  const Text('Adicione uma foto do item perdido (se tiver)', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Escolher foto'),
                  ),
                ],
              ),
      ),
    );
  }
}