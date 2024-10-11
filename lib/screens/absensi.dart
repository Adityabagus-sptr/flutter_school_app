import 'package:flutter/material.dart';

class AbsensiScreen extends StatefulWidget {
  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  List<Map<String, dynamic>> daftarAbsensi = [
    {'tanggal': '2023-06-01', 'status': 'Hadir'},
    {'tanggal': '2023-06-02', 'status': 'Izin'},
    {'tanggal': '2023-06-03', 'status': 'Hadir'},
    {'tanggal': '2023-06-04', 'status': 'Sakit'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
      ),
      body: ListView.builder(
        itemCount: daftarAbsensi.length,
        itemBuilder: (context, index) {
          final absensi = daftarAbsensi[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Tanggal: ${absensi['tanggal']}'),
              subtitle: Text('Status: ${absensi['status']}'),
              trailing: _getIconStatus(absensi['status']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tambahAbsensi(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Absensi',
      ),
    );
  }

  Icon _getIconStatus(String status) {
    switch (status) {
      case 'Hadir':
        return Icon(Icons.check_circle, color: Colors.green);
      case 'Izin':
        return Icon(Icons.info, color: Colors.blue);
      case 'Sakit':
        return Icon(Icons.healing, color: Colors.orange);
      default:
        return Icon(Icons.error, color: Colors.red);
    }
  }

  void _tambahAbsensi(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tanggal = '';
        String status = 'Hadir';
        return AlertDialog(
          title: Text('Tambah Absensi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Tanggal (YYYY-MM-DD)'),
                onChanged: (value) {
                  tanggal = value;
                },
              ),
              DropdownButton<String>(
                value: status,
                items: ['Hadir', 'Izin', 'Sakit'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
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
                  daftarAbsensi.add({'tanggal': tanggal, 'status': status});
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
