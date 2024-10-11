import 'package:flutter/material.dart';

class EkstrakurikulerScreen extends StatefulWidget {
  @override
  _EkstrakurikulerScreenState createState() => _EkstrakurikulerScreenState();
}

class _EkstrakurikulerScreenState extends State<EkstrakurikulerScreen> {
  List<Map<String, dynamic>> daftarEkskul = [
    {'nama': 'Pramuka', 'hari': 'Senin', 'waktu': '15:00 - 17:00'},
    {'nama': 'Basket', 'hari': 'Selasa', 'waktu': '15:30 - 17:30'},
    {'nama': 'Paduan Suara', 'hari': 'Rabu', 'waktu': '14:00 - 16:00'},
    {'nama': 'Robotika', 'hari': 'Kamis', 'waktu': '15:00 - 17:00'},
    {'nama': 'Fotografi', 'hari': 'Jumat', 'waktu': '14:30 - 16:30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekstrakurikuler'),
      ),
      body: ListView.builder(
        itemCount: daftarEkskul.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(daftarEkskul[index]['nama']),
              subtitle: Text('${daftarEkskul[index]['hari']}, ${daftarEkskul[index]['waktu']}'),
              trailing: ElevatedButton(
                child: Text('Daftar'),
                onPressed: () {
                  _daftarEkskul(context, daftarEkskul[index]['nama']);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _tambahEkskul(context);
        },
      ),
    );
  }

  void _daftarEkskul(BuildContext context, String namaEkskul) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pendaftaran'),
          content: Text('Apakah Anda yakin ingin mendaftar ke ekstrakurikuler $namaEkskul?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                // Implementasi logika pendaftaran di sini
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berhasil mendaftar ke $namaEkskul')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tambahEkskul(BuildContext context) {
    String nama = '';
    String hari = 'Senin';
    String waktu = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Ekstrakurikuler Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nama Ekstrakurikuler'),
                onChanged: (value) {
                  nama = value;
                },
              ),
              DropdownButton<String>(
                value: hari,
                items: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    hari = newValue!;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Waktu (contoh: 15:00 - 17:00)'),
                onChanged: (value) {
                  waktu = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  daftarEkskul.add({'nama': nama, 'hari': hari, 'waktu': waktu});
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
