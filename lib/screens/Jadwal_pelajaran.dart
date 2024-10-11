import 'package:flutter/material.dart';

class JadwalPelajaranScreen extends StatefulWidget {
  @override
  _JadwalPelajaranState createState() => _JadwalPelajaranState();
}

class _JadwalPelajaranState extends State<JadwalPelajaranScreen> {
  List<String> hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  String hariTerpilih = 'Senin';

  Map<String, List<Map<String, String>>> jadwalPelajaran = {
    'Senin': [
      {'waktu': '07:00 - 08:30', 'pelajaran': 'Matematika'},
      {'waktu': '08:30 - 10:00', 'pelajaran': 'Bahasa Indonesia'},
    ],
    'Selasa': [
      {'waktu': '07:00 - 08:30', 'pelajaran': 'IPA'},
      {'waktu': '08:30 - 10:00', 'pelajaran': 'Bahasa Inggris'},
    ],
    // Tambahkan jadwal untuk hari lainnya
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Pelajaran'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: hariTerpilih,
            items: hariList.map((String hari) {
              return DropdownMenuItem<String>(
                value: hari,
                child: Text(hari),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                hariTerpilih = newValue!;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jadwalPelajaran[hariTerpilih]?.length ?? 0,
              itemBuilder: (context, index) {
                final jadwal = jadwalPelajaran[hariTerpilih]![index];
                return ListTile(
                  title: Text(jadwal['pelajaran']!),
                  subtitle: Text(jadwal['waktu']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
