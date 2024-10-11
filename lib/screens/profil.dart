import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROdnCE-Yz4Y3OR6xyyg60N_UU2g37nwr-X5avJPZ6G9fjjUxaPRURZm1qhx1wG1_e1-cw&usqp=CAU'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Aditya Bagus Saputra',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            _buildInfoItem('Email', 'aditya@example.com'),
            _buildInfoItem('Nomor Telepon', '+62 123 4567 8900'),
            _buildInfoItem('Alamat', 'Jl. Contoh No. 123, Jakarta'),
            _buildInfoItem('Program Studi', 'Teknik Informatika'),
            _buildInfoItem('Angkatan', '2023'),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implementasi fungsi edit profil
                },
                child: Text('Edit Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
          Divider(),
        ],
      ),
    );
  }
}
