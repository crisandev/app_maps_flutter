import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//CRISTIAN EULISES SANCHEZ RAMIREZ
//2021-1899

class MapPage extends StatefulWidget {
  final String name;
  final String lastname;
  final double latitude;
  final double longitude;

  const MapPage(
      {super.key,
      required this.name,
      required this.lastname,
      required this.latitude,
      required this.longitude});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    LatLng position = LatLng(widget.latitude, widget.longitude);
    _addMarkerWithInfo(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubicación"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude), zoom: 13),
          markers: markers,
          zoomControlsEnabled: false,
        ),
        Positioned(
          top: 23,
          right: 16,
          child: Column(children: [
            FloatingActionButton(
              onPressed: _zoomIn,
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 16,
            ),
            FloatingActionButton(
              onPressed: _zoomOut,
              child: const Icon(Icons.remove),
            )
          ]),
        )
      ]),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _addMarkerWithInfo(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String city = placemarks[0].administrativeArea ?? "Ciudad no encontrada";
    String country = placemarks.first.country ?? "País no encontrado";

    markers.add(Marker(
      markerId: const MarkerId("location"),
      position: position,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Información del marcador"),
                content: Text(
                    "Ciudad: $city\nPaís: $country\nNombre: ${widget.name}\nApellido: ${widget.lastname}"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar"))
                ],
              );
            });
      },
    ));
    setState(() {});
  }

  void _zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }
}
