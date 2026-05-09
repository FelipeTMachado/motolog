import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/manutencao.dart';
import 'cadastro_screen.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  List<Manutencao> _lista = [];

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  Future<void> _carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historicoJson = prefs.getStringList('historico_lista') ?? [];
    
    setState(() {
      _lista = historicoJson.map((item) => Manutencao.fromMap(jsonDecode(item))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          bool? salvou = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroScreen()));
          if (salvou == true) _carregarHistorico();
        },
      ),
      body: _lista.isEmpty 
        ? const Center(child: Text('Nenhum registro encontrado'))
        : ListView.builder(
            itemCount: _lista.length,
            itemBuilder: (context, index) {
              final item = _lista[index];
              return ListTile(
                leading: const Icon(Icons.settings),
                title: Text(item.titulo),
                subtitle: Text('Data: ${item.data} - Km: ${item.km}'),
              );
            },
          ),
    );
  }
}