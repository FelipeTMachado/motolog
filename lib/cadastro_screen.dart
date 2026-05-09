import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/manutencao.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _tituloController = TextEditingController();
  final _kmController = TextEditingController();
  final _dataController = TextEditingController();

  Future<void> _salvarNoHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Pega a lista atual do histórico
    List<String> historicoJson = prefs.getStringList('historico_lista') ?? [];

    // Cria a nova manutenção
    final nova = Manutencao(
      titulo: _tituloController.text,
      data: _dataController.text,
      km: _kmController.text,
    );

    // Adiciona na lista convertendo para string JSON
    historicoJson.add(jsonEncode(nova.toMap()));
    
    await prefs.setStringList('historico_lista', historicoJson);

    if (mounted) Navigator.pop(context, true); // Volta avisando que salvou
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Manutenção')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _tituloController, decoration: const InputDecoration(labelText: 'O que foi feito?')),
            TextField(controller: _dataController, decoration: const InputDecoration(labelText: 'Data')),
            TextField(controller: _kmController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Km atual')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _salvarNoHistorico, child: const Text('Salvar no Histórico'))
          ],
        ),
      ),
    );
  }
}