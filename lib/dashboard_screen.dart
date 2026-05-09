import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'historico_screen.dart';
import 'info_moto_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _kmAtualController = TextEditingController();
  final TextEditingController _kmTrocaController = TextEditingController();
  
  int _kmAtual = 0;
  int _kmTroca = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _kmAtual = prefs.getInt('kmAtual') ?? 0;
      _kmTroca = prefs.getInt('kmTroca') ?? 0;
      
      if (_kmAtual > 0) _kmAtualController.text = _kmAtual.toString();
      if (_kmTroca > 0) _kmTrocaController.text = _kmTroca.toString();
    });
  }

  Future<void> _salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    
    int atual = int.tryParse(_kmAtualController.text) ?? 0;
    int troca = int.tryParse(_kmTrocaController.text) ?? 0;

    await prefs.setInt('kmAtual', atual);
    await prefs.setInt('kmTroca', troca);

    setState(() {
      _kmAtual = atual;
      _kmTroca = troca;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int kmRestante = _kmTroca - _kmAtual;
    bool precisaTrocar = kmRestante <= 0;

    return Scaffold(
      appBar: AppBar(title: const Text('MotoLog - Óleo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _kmAtualController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Km Atual da Moto'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _kmTrocaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Km da Próxima Troca'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarDados,
              child: const Text('Salvar Registros'),
            ),
            const Divider(height: 40),
            Text(
              'Status da Troca de Óleo:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              precisaTrocar 
                  ? 'ALERTA: Passou da hora de trocar!' 
                  : 'Faltam $kmRestante km',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: precisaTrocar ? Colors.red : Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoricoScreen()),
                );
              },
              icon: const Icon(Icons.history),
              label: const Text('Ver Histórico'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoMotoScreen()),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Especificações da Moto'),
            ),
          ],
        ),
      ),
    );
  }
}