import 'package:flutter/material.dart';

class InfoMotoScreen extends StatelessWidget {
  const InfoMotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ficha Técnica - CB 300F')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.motorcycle, size: 80, color: Colors.red),
            const Card(
              child: ListTile(
                title: Text('Motor', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Monocilíndrico, 4 tempos, refrigeração a ar.'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Capacidade do Óleo', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('1,5 litro (total) / 1,3 litro (troca).'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Óleo Recomendado', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Pro Honda SAE 10W-30 API SL ou superior.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}