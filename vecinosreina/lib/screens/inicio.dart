import 'package:flutter/material.dart';
import 'package:vecinosreina/screens/actividad.dart';
import 'package:vecinosreina/screens/crearActividad.dart'; 

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Color secondaryColor = cs.primary;

    return Scaffold(
      appBar: _InicioAppBar(cs: cs), 
      body: const _InicioBody(),
      bottomNavigationBar: _InicioBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        secondaryColor: secondaryColor, 
      ),
    );
  }
}

class _InicioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorScheme cs;
  
  const _InicioAppBar({required this.cs}); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: cs.primary,
      title: Text(
        'La Reina',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.white),
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
    final tt = Theme.of(context).textTheme;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MainBanner(
            imagePath: 'assets/talleres-infantiles.png',
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Talleres',
              style: tt.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          _WorkshopCard(
            title: 'Pintura',
            schedule: 'Martes/12:30-14:30',
            imagePath: 'assets/pintura.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActividadScreen()), 
              );
            },
          ),

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

class _MainBanner extends StatelessWidget {
  final String imagePath;
  
  const _MainBanner({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, 
      width: double.infinity,

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

    final Color linkColor = cs.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(

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
                            color: linkColor, 
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
      backgroundColor: secondaryColor, 
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined,color: Colors.white,),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add,color: Colors.white,),
          label: 'Crear actividades',
        ),
      ],
    );
  }
}