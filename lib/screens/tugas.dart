import 'package:flutter/material.dart';

class TugasScreen extends StatefulWidget {
  @override
  _TugasScreenState createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  List<Tugas> daftarTugas = [
    Tugas(
      mataPelajaran: 'Matematika',
      judul: 'PR Aljabar',
      deskripsi: 'Kerjakan halaman 45-50',
      tenggat: DateTime(2023, 6, 30),
    ),
    Tugas(
      mataPelajaran: 'Bahasa Indonesia',
      judul: 'Menulis Esai',
      deskripsi: 'Tulis esai tentang pahlawan nasional',
      tenggat: DateTime(2023, 7, 5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      body: ListView.builder(
        itemCount: daftarTugas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(daftarTugas[index].judul),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(daftarTugas[index].mataPelajaran),
                  Text('Tenggat: ${daftarTugas[index].tenggat.toString().split(' ')[0]}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _tampilkanDetailTugas(context, daftarTugas[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _tambahTugas(context);
        },
      ),
    );
  }

  void _tampilkanDetailTugas(BuildContext context, Tugas tugas) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tugas.judul),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mata Pelajaran: ${tugas.mataPelajaran}'),
              SizedBox(height: 8),
              Text('Deskripsi: ${tugas.deskripsi}'),
              SizedBox(height: 8),
              Text('Tenggat: ${tugas.tenggat.toString().split(' ')[0]}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tambahTugas(BuildContext context) {
    // Implementasi penambahan tugas baru
    // Anda dapat menambahkan form input di sini
  }
}

class Tugas {
  final String mataPelajaran;
  final String judul;
  final String deskripsi;
  final DateTime tenggat;

  Tugas({
    required this.mataPelajaran,
    required this.judul,
    required this.deskripsi,
    required this.tenggat,
  });
}
