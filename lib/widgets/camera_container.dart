import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraDrug extends StatefulWidget {
  const CameraDrug(this.cameras);

  final List<CameraDescription>? cameras;

  @override
  State<CameraDrug> createState() => _CameraDrugState();
}

class _CameraDrugState extends State<CameraDrug> {
  late CameraController controller;
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Fail to pick IMG: $e');
    }
  }

  Future takePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Fail to pick IMG: $e');
    }
  }

  @override
  void initState() {
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return const Center(
        child: Text('Please allow use of Camera Permission'),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.6,
              child: image != null
                  ? Image.file(image!)
                  : CameraPreview(controller),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            imageButton('pick'),
            imageButton('take'),
          ],
        ),
        // if (pictureFile != null) Image.network(pictureFile!.path)
        //if (pictureFile != null) Image.network(pictureFile!.path)
      ],
    );
  }
}

class imageButton extends StatelessWidget {
  imageButton(this.type);

  final String type;

  final _CameraDrugState obj = _CameraDrugState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        width: 180,
        child: ElevatedButton.icon(
          onPressed: () async {
            type == 'pick' ? obj.pickImage() : obj.takePicture();
          },
          icon: type == 'pick'
              ? const Icon(Icons.image_outlined)
              : const Icon(Icons.camera),
          label: Text(type == 'pick' ? 'Pick Image' : 'Take Image'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                type == 'pick' ? Colors.blue : Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
