import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/models/prescription.dart';
import 'package:hci_customer/provider/general_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/payment_complete.dart';
import '../screens/presciption_screen.dart';

class PrescriptionInfo extends ConsumerStatefulWidget {
  const PrescriptionInfo(this.onClicked);
  final Function onClicked;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrescriptionInfoState();
}

class _PrescriptionInfoState extends ConsumerState<PrescriptionInfo> {
  final nameCtl = TextEditingController();
  final addrCtl = TextEditingController();

  @override
  void initState() {
    nameCtl.text = '';
    addrCtl.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    Text(
                      ref.watch(UserProvider).currentUser!.displayName ?? '',
                      style: const TextStyle(fontSize: 20, letterSpacing: 1),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ref.watch(UserProvider).currentUser!.email ?? '',
                      style: const TextStyle(fontSize: 20, letterSpacing: 1),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Patient Name';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Patient Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Address';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Address'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: uploadImg,
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('We will contact you after we receive the presciption'),
          ],
        ),
      ),
    );
  }

  Future uploadImg() async {
    SendPresciprClass(ref.watch(ImgPath)).myAsyncMethod(context, (value) {
      final prescrip = Prescription(
        name: nameCtl.text,
        addr: addrCtl.text,
        mail: FirebaseAuth.instance.currentUser!.email.toString(),
        Imgurl: value,
      );
      print(prescrip.toString());
      if (!mounted) return;
      if (value.length > 10) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentCompleteScreen(),
          ),
        );
      }
    });
  }
}

class SendPresciprClass {
  SendPresciprClass(this.xfile);

  final XFile? xfile;

  Future<void> myAsyncMethod(BuildContext context, Function onSuccess) async {
    UploadTask? uploadTask;
    final file = File(xfile!.path);
    final path = 'prescription/${xfile!.name}';

    final send = FirebaseStorage.instance.ref().child(path);
    uploadTask = send.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    String url = await snapshot.ref.getDownloadURL();
    onSuccess(url);
  }
}
