import 'package:flutter/material.dart';

class IPAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IPA'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Fisika',
            'Pelajari hukum-hukum alam dan energi',
            Icons.flash_on,
          ),
          _buildSectionCard(
            'Kimia',
            'Eksplorasi materi dan reaksinya',
            Icons.science,
          ),
          _buildSectionCard(
            'Biologi',
            'Pelajari makhluk hidup dan lingkungannya',
            Icons.eco,
          ),
          _buildSectionCard(
            'Astronomi',
            'Jelajahi alam semesta dan benda-benda langit',
            Icons.star,
          ),
          _buildSectionCard(
            'Geologi',
            'Pelajari struktur dan sejarah Bumi',
            Icons.landscape,
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
          backgroundColor: Colors.green,
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
