import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  List<Agenda> agendaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAgenda();
  }

  Future<void> fetchAgenda() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          agendaList = data.map((item) => Agenda.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Gagal memuat data agenda');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackBar('Gagal memuat data: $e');
    }
  }

  Future<void> tambahAgenda(Agenda agenda) async {
    try {
      final response = await http.post(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'),
        body: json.encode(agenda.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchAgenda();
        _showSuccessSnackBar('Agenda berhasil ditambahkan');
      } else {
        throw Exception('Gagal menambah agenda');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal menambah agenda: $e');
    }
  }

  Future<void> updateAgenda(Agenda agenda) async {
    try {
      final response = await http.put(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'),
        body: json.encode(agenda.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchAgenda();
        _showSuccessSnackBar('Agenda berhasil diperbarui');
      } else {
        throw Exception('Gagal memperbarui agenda');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal memperbarui agenda: $e');
    }
  }

  Future<void> hapusAgenda(int kdAgenda) async {
    try {
      final response = await http.delete(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda&kd_agenda=$kdAgenda'),
      );
      if (response.statusCode == 200) {
        fetchAgenda();
        _showSuccessSnackBar('Agenda berhasil dihapus');
      } else {
        throw Exception('Gagal menghapus agenda');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal menghapus agenda: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchAgenda,
              child: ListView.builder(
                itemCount: agendaList.length,
                itemBuilder: (context, index) {
                  return _buildAgendaItem(agendaList[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAgendaDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Agenda',
        backgroundColor: const Color.fromARGB(255, 216, 219, 222),
      ),
    );
  }

  void _showAddAgendaDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String judulAgenda = '';
    String isiAgenda = '';
    String tglAgenda = '';
    String statusAgenda = 'Aktif';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Agenda Baru'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Judul Agenda'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap isi judul agenda';
                      }
                      return null;
                    },
                    onSaved: (value) => judulAgenda = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Isi Agenda'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap isi konten agenda';
                      }
                      return null;
                    },
                    onSaved: (value) => isiAgenda = value!,
                    maxLines: 3,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tanggal Agenda (YYYY-MM-DD)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap isi tanggal agenda';
                      }
                      // Tambahkan validasi format tanggal jika diperlukan
                      return null;
                    },
                    onSaved: (value) => tglAgenda = value!,
                  ),
                  DropdownButtonFormField<String>(
                    value: statusAgenda,
                    decoration: InputDecoration(labelText: 'Status Agenda'),
                    items: ['Aktif', 'Tidak Aktif'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      statusAgenda = newValue!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newAgenda = Agenda(
                    kdAgenda: 0, // ID akan diberikan oleh server
                    judulAgenda: judulAgenda,
                    isiAgenda: isiAgenda,
                    tglAgenda: tglAgenda,
                    tglPostAgenda: DateTime.now().toIso8601String(),
                    statusAgenda: statusAgenda,
                    kdPetugas: null, // Sesuaikan dengan kebutuhan
                  );
                  tambahAgenda(newAgenda);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAgendaItem(Agenda agenda) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {
          // Implementasi untuk melihat detail agenda
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                agenda.judulAgenda,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.0, color: Colors.grey),
                  SizedBox(width: 4.0),
                  Text(
                    _formatDate(agenda.tglAgenda),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                agenda.isiAgenda,
                style: TextStyle(fontSize: 16.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(agenda.statusAgenda),
                    backgroundColor: agenda.statusAgenda == 'Aktif' ? Colors.green[100] : Colors.red[100],
                    labelStyle: TextStyle(color: agenda.statusAgenda == 'Aktif' ? Colors.green : Colors.red),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Implementasi untuk mengedit agenda
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text('Apakah Anda yakin ingin menghapus agenda ini?'),
                                actions: [
                                  TextButton(
                                    child: Text('Batal'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: Text('Hapus'),
                                    onPressed: () {
                                      hapusAgenda(agenda.kdAgenda);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return monthNames[month - 1];
  }
}

class Agenda {
  final int kdAgenda;
  final String judulAgenda;
  final String isiAgenda;
  final String tglAgenda;
  final String tglPostAgenda;
  final String statusAgenda;
  final int? kdPetugas;

  Agenda({
    required this.kdAgenda,
    required this.judulAgenda,
    required this.isiAgenda,
    required this.tglAgenda,
    required this.tglPostAgenda,
    required this.statusAgenda,
    this.kdPetugas,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      kdAgenda: int.parse(json['kd_agenda']),
      judulAgenda: json['judul_agenda'],
      isiAgenda: json['isi_agenda'],
      tglAgenda: json['tgl_agenda'],
      tglPostAgenda: json['tgl_post_agenda'],
      statusAgenda: json['status_agenda'],
      kdPetugas: json['kd_petugas'] != null ? int.parse(json['kd_petugas']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kd_agenda': kdAgenda.toString(),
      'judul_agenda': judulAgenda,
      'isi_agenda': isiAgenda,
      'tgl_agenda': tglAgenda,
      'tgl_post_agenda': tglPostAgenda,
      'status_agenda': statusAgenda,
      'kd_petugas': kdPetugas?.toString(),
    };
  }
}
