import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vecinosreina/screens/actividad.dart';
import 'package:vecinosreina/screens/inicio.dart';

class crearActividadScreen extends StatefulWidget {
  const crearActividadScreen({super.key});

  @override
  State<crearActividadScreen> createState() => _crearActividadScreenState();
}

class _crearActividadScreenState extends State<crearActividadScreen> {
  File? _pickedImageFile;
  final _picker = ImagePicker();
  int _currentIndex = 2;

  void _onTabTapped(int index) {
     if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioScreen()),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ActividadScreen()),
      );
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const crearActividadScreen()),
      );
    }
  }

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, 
      maxWidth: 150,
    );

    if (pickedImage != null) {
      _pickedImageFile = File(pickedImage.path);
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('actividades_img') 
          .child('${DateTime.now().toIso8601String()}.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      if (kDebugMode) {
        print('Error al subir la imagen: $error');
      }
      return null;
    }
  }

  void _addProduct(BuildContext context) async {
    final titleController = TextEditingController();
    final categoriaController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    setState(() {
      _pickedImageFile = null;
    });

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 300),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Crear actividad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () async {
                        _pickImage();
                        setDialogState(() {});
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade200,
                        foregroundImage: _pickedImageFile != null
                            ? FileImage(_pickedImageFile!)
                            : null,
                        child: _pickedImageFile == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 30,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: categoriaController,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          onPressed: () async {
                            final title = titleController.text.trim();
                            final description = descriptionController.text
                                .trim();
                            final categoria = categoriaController.text.trim();
                            final price = double.tryParse(
                              priceController.text.trim(),
                            );

                            if (title.isNotEmpty &&
                                description.isNotEmpty &&
                                categoria.isNotEmpty &&
                                price != null &&
                                _pickedImageFile != null) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Creando actividad...',
                                  ),
                                ),
                              );

                              final imageUrl = await _uploadImage(
                                _pickedImageFile!,
                              );

                              if (imageUrl != null) {
                                await FirebaseFirestore.instance
                                    .collection('Tus Actividades')
                                    .add({
                                      'Titulo': title,
                                      'Detalle': description,
                                      'Categoria':categoria,
                                      'Precio': price,
                                      'imageUrl': imageUrl,
                                      'timestamp': FieldValue.serverTimestamp(),
                                    });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Actividad creada correctamente',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error al subir la imagen.'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Por favor, complete todos los campos y seleccione una imagen.',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Guardar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _editProduct(
    BuildContext context,
    String docId,
    Map<String, dynamic> data,
  ) async {
    final titleController = TextEditingController(text: data['Titulo']);
    final categoriaController = TextEditingController(text: data['Categoria']);
    final descriptionController = TextEditingController(
      text: data['Detalle'],
    );
    final priceController = TextEditingController(
      text: data['Precio'].toString(),
    );

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Editar actividad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                      ),
                      onPressed: () async {
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();
                        final price = double.tryParse(
                          priceController.text.trim(),
                        );

                        if (title.isNotEmpty &&
                            description.isNotEmpty &&
                            price != null) {
                          await FirebaseFirestore.instance
                              .collection('Tus Actividades')
                              .doc(docId)
                              .update({
                                'Titulo': title,
                                'Detalle': description,
                                'Precio': price,
                              });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Actividad actualizado correctamente',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteProduct(BuildContext context, String docId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar actividad'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar este actividad?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection('Tus Actividades')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Actividad eliminada correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Actividades'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ActividadScreen()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Tus Actividades')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar actividades'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No hay actividades creadas'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final imageUrl = data['imageUrl'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),

                  leading: imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                          ),
                        )
                      : const Icon(
                          Icons.shopping_bag,
                          size: 60,
                          color: Colors.grey,
                        ), 

                  title: Text(
                    data['Titulo'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(data['Detalle'] ?? ''),
                      const SizedBox(height: 4),
                      Text(data['Categoria'] ?? ''),
                      const SizedBox(height: 4),
                      Text('\$${data['Precio']?.toStringAsFixed(2) ?? '0'}'),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'editar') {
                        _editProduct(context, doc.id, data);
                      } else if (value == 'eliminar') {
                        _deleteProduct(context, doc.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'editar',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem(
                        value: 'eliminar',
                        child: Text('Eliminar'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: _onTabTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        backgroundColor: cs.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: 'Home',),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.white,),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.white,), label: 'Crear actividades'),
        ],
      ),
    );
  }
}
