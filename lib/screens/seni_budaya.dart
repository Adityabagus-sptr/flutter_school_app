import 'package:flutter/material.dart';

class SeniBudayaScreen extends StatelessWidget {
  const SeniBudayaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seni Budaya'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Seni Rupa',
            'Pelajari berbagai bentuk seni visual',
            Icons.palette,
          ),
          _buildSectionCard(
            'Seni Musik',
            'Eksplorasi dunia nada dan melodi',
            Icons.music_note,
          ),
          _buildSectionCard(
            'Seni Tari',
            'Pelajari gerakan dan koreografi',
            Icons.directions_run,
          ),
          _buildSectionCard(
            'Seni Teater',
            'Kembangkan kemampuan akting dan drama',
            Icons.theater_comedy,
          ),
          _buildSectionCard(
            'Budaya Daerah',
            'Pelajari keragaman budaya Indonesia',
            Icons.location_city,
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
          backgroundColor: Colors.purple,
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
