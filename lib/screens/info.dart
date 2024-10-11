import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<Informasi> informasiList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInformasi();
  }

  Future<void> fetchInformasi() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          informasiList = data.map((item) => Informasi.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Gagal memuat data informasi');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackBar('Gagal memuat data: $e');
    }
  }

  Future<void> tambahInformasi(Informasi informasi) async {
    try {
      final response = await http.post(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'),
        body: json.encode(informasi.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchInformasi();
        _showSuccessSnackBar('Informasi berhasil ditambahkan');
      } else {
        throw Exception('Gagal menambah informasi');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal menambah informasi: $e');
    }
  }

  Future<void> updateInformasi(Informasi informasi) async {
    try {
      final response = await http.put(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'),
        body: json.encode(informasi.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchInformasi();
        _showSuccessSnackBar('Informasi berhasil diperbarui');
      } else {
        throw Exception('Gagal memperbarui informasi');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal memperbarui informasi: $e');
    }
  }

  Future<void> hapusInformasi(int kdInfo) async {
    try {
      final response = await http.delete(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi&kd_info=$kdInfo'),
      );
      if (response.statusCode == 200) {
        fetchInformasi();
        _showSuccessSnackBar('Informasi berhasil dihapus');
      } else {
        throw Exception('Gagal menghapus informasi');
      }
    } catch (e) {
      _showErrorSnackBar('Gagal menghapus informasi: $e');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchInformasi,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : informasiList.isEmpty
              ? Center(child: Text('Tidak ada informasi'))
              : RefreshIndicator(
                  onRefresh: fetchInformasi,
                  child: ListView.builder(
                    itemCount: informasiList.length,
                    itemBuilder: (context, index) {
                      return _buildInfoCard(informasiList[index]);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInformasiDialog(context),
        child: Icon(Icons.add),
        tooltip: 'Tambah Informasi',
      ),
    );
  }

  Widget _buildInfoCard(Informasi informasi) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        title: Text(
          informasi.judulInfo,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Post: ${informasi.tglPostInfo}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            Text(
              'Status: ${informasi.statusInfo}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            if (informasi.kdPetugas != null)
              Text(
                'Kode Petugas: ${informasi.kdPetugas}',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  informasi.isiInfo,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('Edit'),
                      onPressed: () => _showEditInformasiDialog(context, informasi),
                    ),
                    SizedBox(width: 8.0),
                    TextButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Hapus'),
                      onPressed: () => _showDeleteConfirmationDialog(context, informasi),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddInformasiDialog(BuildContext context) {
    final _judulController = TextEditingController();
    final _isiController = TextEditingController();
    final _statusController = TextEditingController();
    final _kdPetugasController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Informasi Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _judulController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _isiController,
                  decoration: InputDecoration(
                    labelText: 'Isi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _kdPetugasController,
                  decoration: InputDecoration(
                    labelText: 'Kode Petugas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_judulController.text.isNotEmpty && _isiController.text.isNotEmpty) {
                  final newInformasi = Informasi(
                    kdInfo: 0,
                    judulInfo: _judulController.text,
                    isiInfo: _isiController.text,
                    tglPostInfo: DateTime.now().toIso8601String(),
                    statusInfo: _statusController.text.isNotEmpty ? _statusController.text : 'aktif',
                    kdPetugas: _kdPetugasController.text.isNotEmpty ? int.parse(_kdPetugasController.text) : null,
                  );
                  tambahInformasi(newInformasi);
                  Navigator.of(context).pop();
                } else {
                  _showErrorSnackBar('Judul dan isi harus diisi');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditInformasiDialog(BuildContext context, Informasi informasi) {
    final _judulController = TextEditingController(text: informasi.judulInfo);
    final _isiController = TextEditingController(text: informasi.isiInfo);
    final _statusController = TextEditingController(text: informasi.statusInfo);
    final _kdPetugasController = TextEditingController(text: informasi.kdPetugas?.toString() ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Informasi'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _judulController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _isiController,
                  decoration: InputDecoration(
                    labelText: 'Isi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _kdPetugasController,
                  decoration: InputDecoration(
                    labelText: 'Kode Petugas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_judulController.text.isNotEmpty && _isiController.text.isNotEmpty) {
                  final updatedInformasi = Informasi(
                    kdInfo: informasi.kdInfo,
                    judulInfo: _judulController.text,
                    isiInfo: _isiController.text,
                    tglPostInfo: informasi.tglPostInfo,
                    statusInfo: _statusController.text,
                    kdPetugas: _kdPetugasController.text.isNotEmpty ? int.parse(_kdPetugasController.text) : null,
                  );
                  updateInformasi(updatedInformasi);
                  Navigator.of(context).pop();
                } else {
                  _showErrorSnackBar('Judul dan isi harus diisi');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Informasi informasi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus informasi ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Hapus'),
              onPressed: () {
                hapusInformasi(informasi.kdInfo);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}

class Informasi {
  final int kdInfo;
  final String judulInfo;
  final String isiInfo;
  final String tglPostInfo;
  final String statusInfo;
  final int? kdPetugas;

  Informasi({
    required this.kdInfo,
    required this.judulInfo,
    required this.isiInfo,
    required this.tglPostInfo,
    required this.statusInfo,
    this.kdPetugas,
  });

  factory Informasi.fromJson(Map<String, dynamic> json) {
    return Informasi(
      kdInfo: int.parse(json['kd_info']),
      judulInfo: json['judul_info'],
      isiInfo: json['isi_info'],
      tglPostInfo: json['tgl_post_info'],
      statusInfo: json['status_info'],
      kdPetugas: json['kd_petugas'] != null ? int.parse(json['kd_petugas']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kd_info': kdInfo.toString(),
      'judul_info': judulInfo,
      'isi_info': isiInfo,
      'tgl_post_info': tglPostInfo,
      'status_info': statusInfo,
      'kd_petugas': kdPetugas?.toString(),
    };
  }
}
