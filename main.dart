import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Peminjaman Kendaraan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
      routes: {
        '/info': (context) => SecondPage(),
      },
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _selectedVehicle = '';
  String _selectedDuration = '';
  bool _withDriver = false;

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(
        context,
        '/info',
        arguments: {
          'nama': _namaController.text,
          'prodi': _prodiController.text,
          'fakultas': _fakultasController.text,
          'jenisKendaraan': _selectedVehicle,
          'durasiPeminjaman': _selectedDuration,
          'denganSupir': _withDriver,
        },
      );
    }
  }

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _fakultasController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _prodiController.dispose();
    _fakultasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Peminjaman Kendaraan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prodiController,
                decoration: InputDecoration(labelText: 'Program Studi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Program Studi harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fakultasController,
                decoration: InputDecoration(labelText: 'Fakultas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fakultas harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Jenis Kendaraan'),
              RadioListTile(
                title: Text('Avanza/Xenia'),
                value: 'Avanza/Xenia',
                groupValue: _selectedVehicle,
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('Elf'),
                value: 'Elf',
                groupValue: _selectedVehicle,
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Durasi Peminjaman Kendaraan'),
              RadioListTile(
                title: Text('12 Jam'),
                value: '12 Jam',
                groupValue: _selectedDuration,
                onChanged: (value) {
                  setState(() {
                    _selectedDuration = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('18 Jam'),
                value: '18 Jam',
                groupValue: _selectedDuration,
                onChanged: (value) {
                  setState(() {
                    _selectedDuration = value.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              CheckboxListTile(
                title: Text('Dengan Supir'),
                value: _withDriver,
                onChanged: (value) {
                  setState(() {
                    _withDriver = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('KIRIM PERMINTAAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Peminjaman Kendaraan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${data['nama']}'),
            Text('Program Studi: ${data['prodi']}'),
            Text('Fakultas: ${data['fakultas']}'),
            Text('Jenis Kendaraan: ${data['jenisKendaraan']}'),
            Text('Durasi Peminjaman: ${data['durasiPeminjaman']}'),
            Text('Dengan Supir: ${data['denganSupir']}'),
          ],
        ),
      ),
    );
  }
}
