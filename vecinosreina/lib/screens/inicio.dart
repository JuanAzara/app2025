import 'package:flutter/material.dart';
// Importa la pantalla a la que navegas desde la tarjeta de taller (ChatsScreen o ActividadScreen)
import 'package:vecinosreina/screens/actividad.dart'; 
// Asumo que ChatsScreen está renombrado o es equivalente a ActividadScreen

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el esquema de color (ColorScheme) y el color secundario
    final cs = Theme.of(context).colorScheme;
    final Color secondaryColor = cs.secondary;

    return Scaffold(
      // CORRECCIÓN: Quitamos el color de fondo fijo. El tema lo maneja.
      // backgroundColor: Colors.white, 
      appBar: _InicioAppBar(cs: cs), // Pasamos el ColorScheme
      body: const _InicioBody(),
      bottomNavigationBar: _InicioBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        secondaryColor: secondaryColor, // Usado para el color de fondo de la barra
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// --- 1. Componentes de UI Modulares ---
// -----------------------------------------------------------------------------

class _InicioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorScheme cs;
  
  // CORRECCIÓN: El constructor ya no es 'const' y requiere cs
  const _InicioAppBar({required this.cs}); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // CORRECCIÓN: Quitamos el color de fondo fijo. El tema lo maneja.
      // backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        // CORRECCIÓN: Usamos el color de contraste del tema (onBackground o onSurface)
        icon: Icon(Icons.arrow_back, color: cs.onBackground),
        onPressed: () {},
      ),
      title: Text(
        'La Reina',
        // CORRECCIÓN: Usamos el color de contraste del tema
        style: TextStyle(color: cs.onBackground),
      ),
      actions: [
        IconButton(
          // CORRECCIÓN: Usamos el color de contraste del tema
          icon: Icon(Icons.more_vert, color: cs.onBackground),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _InicioBody extends StatelessWidget {
  const _InicioBody();

  @override
  Widget build(BuildContext context) {
    // Obtenemos el TextTheme
    final tt = Theme.of(context).textTheme;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MainBanner(
            imagePath: 'assets/talleres-infantiles.png',
          ),

          // Título principal "Talleres"
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Talleres',
              style: tt.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                // CORRECCIÓN: Eliminamos el color fijo (Colors.black). Usamos el TextTheme.
              ),
            ),
          ),

          // Tarjeta de Pintura: NAVEGA A la siguiente pantalla (ChatsScreen/ActividadScreen)
          _WorkshopCard(
            title: 'Pintura',
            schedule: 'Martes/12:30-14:30',
            imagePath: 'assets/pintura.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActividadScreen()), // Usando ActividadScreen
              );
            },
          ),

          // Tarjeta de Baile
          const _WorkshopCard(
            title: 'Baile',
            schedule: 'Jueves/17:30-19:30',
            imagePath: 'assets/danza.png',
            onTap: null, 
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// --- 2. Componentes Visuales Reutilizables ---
// -----------------------------------------------------------------------------

class _MainBanner extends StatelessWidget {
  final String imagePath;
  
  const _MainBanner({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, 
      width: double.infinity,
      // CORRECCIÓN: Quitamos color fijo
      // color: Colors.white, 
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain, 
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200], 
            child: const Center(
              child: Text(
                "Error: Banner no cargado", 
                style: TextStyle(color: Colors.black54, fontSize: 14)
              )
            ),
          );
        },
      ),
    );
  }
}

class _WorkshopCard extends StatelessWidget {
  final String title;
  final String schedule;
  final String imagePath;
  final VoidCallback? onTap; 

  const _WorkshopCard({
    required this.title,
    required this.schedule,
    required this.imagePath,
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    // Obtenemos el color secundario del tema para el enlace "Ver más"
    final Color linkColor = cs.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        // CORRECCIÓN: Quitamos color fijo
        // color: Colors.white, 
        elevation: 0, 
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: tt.titleLarge?.copyWith(
                          // CORRECCIÓN: Eliminamos color fijo (Colors.black)
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        schedule,
                        style: tt.bodyMedium?.copyWith(
                          color: tt.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: onTap, 
                        child: Text(
                          'Ver más',
                          style: TextStyle(
                            color: linkColor, // Usa el color del tema
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Imagen a la derecha
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Container(
                  width: 100, 
                  height: 100,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            'Error: $title', 
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. BottomNavigationBar Componente ---
class _InicioBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color secondaryColor;

  const _InicioBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: secondaryColor, // Usa el color del tema
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}