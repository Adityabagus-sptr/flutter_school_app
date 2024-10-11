import 'package:flutter/material.dart';

class PenjaskesScreen extends StatelessWidget {
  const PenjaskesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendidikan Jasmani dan Kesehatan'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Olahraga Tim',
            'Pelajari berbagai olahraga tim populer',
            Icons.sports_soccer,
          ),
          _buildSectionCard(
            'Atletik',
            'Latihan lari, lompat, dan lempar',
            Icons.directions_run,
          ),
          _buildSectionCard(
            'Senam',
            'Kembangkan fleksibilitas dan kekuatan tubuh',
            Icons.sports_gymnastics,
          ),
          _buildSectionCard(
            'Renang',
            'Pelajari teknik berenang yang benar',
            Icons.pool,
          ),
          _buildSectionCard(
            'Kesehatan',
            'Pelajari tentang gizi dan pola hidup sehat',
            Icons.health_and_safety,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String judul, String deskripsi, IconData ikon) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(ikon, color: Colors.white),
        ),
        title: Text(
          judul,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(deskripsi),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Implementasi navigasi ke halaman detail materi
        },
      ),
    );
  }
}
