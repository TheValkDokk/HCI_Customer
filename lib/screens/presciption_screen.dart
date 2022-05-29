import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hci_customer/widgets/camera_container.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  late final cameras;

  Future<List<CameraDescription>> callCamera() async {
    return await availableCameras().then((value) => cameras = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: callCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Center(
                child: CameraDrug(cameras),
              );
            } else {
              return const Center(
                child: Text('No Camera'),
              );
            }
          }),
    );
  }
}
