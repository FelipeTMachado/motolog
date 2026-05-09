class Manutencao {
  final String titulo;
  final String data;
  final String km;

  Manutencao({required this.titulo, required this.data, required this.km});

  // CONVERTE O OBJETO PARA MAP
  Map<String, dynamic> toMap() => {
    'titulo': titulo,
    'data': data,
    'km': km,
  };

  // CONVERTE O MAP PARA OBJETO
  factory Manutencao.fromMap(Map<String, dynamic> map) => Manutencao(
    titulo: map['titulo'],
    data: map['data'],
    km: map['km'],
  );
}