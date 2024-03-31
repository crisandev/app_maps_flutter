import 'package:app_maps/pages/map_page.dart';
import 'package:flutter/material.dart';

//CRISTIAN EULISES SANCHEZ RAMIREZ 
//2021-1899
class InfoLocation extends StatefulWidget {
  const InfoLocation({super.key});

  @override
  State<InfoLocation> createState() => _InfoLocationState();
}

class _InfoLocationState extends State<InfoLocation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completa tus datos y ubicación"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField("Nombre", _nameController),
            const SizedBox(height: 16),
            _buildTextField("Apellido", _lastnameController),
            const SizedBox(height: 16),
            _buildTextField("Latitud", _latitudeController),
            const SizedBox(height: 16),
            _buildTextField("Longitud", _longitudeController),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {
                  _showMap();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Siguiente",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0))),
    );
  }

  void _showMap() {
    final String name = _nameController.text;
    final String lastname = _lastnameController.text;
    final double latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    final double longitude = double.tryParse(_longitudeController.text) ?? 0.0;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapPage(
                name: name,
                lastname: lastname,
                latitude: latitude,
                longitude: longitude)));
  }
}
