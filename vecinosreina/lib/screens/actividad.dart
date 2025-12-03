import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vecinosreina/screens/crearActividad.dart';
import 'package:vecinosreina/screens/formulario.dart';

class ActividadScreen extends StatefulWidget {
  const ActividadScreen({super.key});

  @override
  State<ActividadScreen> createState() => _ActividadScreenState();
}

class _ActividadScreenState extends State<ActividadScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const crearActividadScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.primary,
        title: Text(
          'Vecinos Reina',
          style: tt.titleLarge?.copyWith(color: cs.onPrimary),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/pintura.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pintura',
                    style: tt.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.bookmark_border, color: tt.bodyMedium?.color),
                      const SizedBox(width: 8),
                      Icon(Icons.share, color: tt.bodyMedium?.color),
                    ],
                  ),
                ],
              ),

              const Divider(),
              const SizedBox(height: 5),

              Text(
                'Overline',
                style: tt.labelSmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 3),

              Text('Descripción', style: tt.titleSmall),

              Text(
                'Descubre los fundamentos de la pintura en este entretenido taller donde podrás dar rienda suelta a tu creatividad y crear piezas únicas.',
                style: tt.bodySmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),

              Text(
                'Overline',
                style: tt.labelSmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 3),

              Text('Precio', style: tt.titleSmall),

              Text(
                'Normal/Vecino: 20.000 por mes.',
                style: tt.bodySmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Adulto Mayor: 15.000 por mes.',
                style: tt.bodySmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'No Vecino: 35.000 por mes.',
                style: tt.bodySmall?.copyWith(
                  color: tt.bodySmall?.color?.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 5),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TallerPinturaScreen()),
      );},
                  child: const Text('INSCRIBETE'),
                  
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              Text(
                'Comentarios',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const CommentInputField(tallerId: 'pintura'),

              const SizedBox(height: 12),

              const CommentsList(tallerId: 'pintura'),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: cs.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class CommentInputField extends StatefulWidget {
  const CommentInputField({super.key, required this.tallerId});
  final String tallerId;

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _sending = false;

  Future<void> _send() async {
    final scaffoldContext = context;
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);

    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'text': text,
        'tallerId': widget.tallerId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _controller.clear();

      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        const SnackBar(content: Text('Comentario publicado')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          maxLines: 3, 
          decoration: InputDecoration(
            hintText: 'Escribe un comentario',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: cs.primary),
            foregroundColor: cs.primary,
            padding: const EdgeInsets.symmetric(vertical: 13),
          ),
          onPressed: _sending ? null : _send,
          child: _sending
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Comentar'),
        ),
      ],
    );
  }
}

class CommentsList extends StatefulWidget {
  const CommentsList({super.key, required this.tallerId});
  final String tallerId;

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  Future<void> _editComment(
      BuildContext dialogContext, String docId, String currentText) async {
    final scaffoldContext = context;
    final controller = TextEditingController(text: currentText);

    await showDialog(
      context: dialogContext,
      builder: (context) {
        final tt = Theme.of(context).textTheme;
        final cs = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Text('Editar comentario', style: tt.titleMedium),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
              ),
              onPressed: () async {
                final newText = controller.text.trim();

                if (newText.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('comments')
                      .doc(docId)
                      .update({'text': newText});
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                  const SnackBar(content: Text('Comentario actualizado')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteComment(
      BuildContext dialogContext, String docId) async {
    final scaffoldContext = context;

    final confirm = await showDialog<bool>(
      context: dialogContext,
      builder: (context) {
        final tt = Theme.of(context).textTheme;
        final cs = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Text('Eliminar comentario', style: tt.titleMedium),
          content:
              const Text('¿Estás seguro que quieres eliminar tu comentario?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection('comments')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        const SnackBar(content: Text('Comentario eliminado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = FirebaseFirestore.instance
        .collection('comments')
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return const Text('Sé el primero en comentar.');
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          separatorBuilder: (_, _) => const Divider(height: 12),
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final text = (data['text'] ?? data['name'] ?? '').toString();

            final ts = data['timestamp'] as Timestamp?;
            final dt = ts?.toDate();

            return ListTile(
              dense: true,
              leading: const Icon(Icons.comment),
              title: Text(text),
              subtitle: dt != null
                  ? Text(
                      '${dt.day}/${dt.month}/${dt.year} '
                      '${dt.hour.toString().padLeft(2, '0')}:'
                      '${dt.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  : const Text(
                      'Enviando…',
                      style: TextStyle(fontSize: 12),
                    ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'edit') {
                    _editComment(context, doc.id, text);
                  } else if (value == 'delete') {
                    _deleteComment(context, doc.id);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Eliminar'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}