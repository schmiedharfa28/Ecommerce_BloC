import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  final String? telp, nama, email;
  final XFile? image;
  final void Function(String? telp, String? nama, String? email, XFile? image)?
      onUpdate;

  const UpdateProfile(
      {this.telp, this.nama, this.email, this.image, @required this.onUpdate});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController? telp, nama, email;
  XFile? image;

  Future<void> getImageCamera() async {
    var takeImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (takeImage != null) {
      setState(() {
        image = takeImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nama = TextEditingController(text: widget.nama);
    telp = TextEditingController(text: widget.telp);
    email = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: getImageCamera,
                child: image != null
                    ? Image.file(
                        File(image!.path),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fitWidth,
                      )
                    : Text(
                        "Select Image",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nama,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  hintText: 'Nama'),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  hintText: 'email'),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: telp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  hintText: 'Nomor Telp'),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              minWidth: 200,
              textColor: Colors.white,
              color: Colors.black,
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                widget.onUpdate!(telp?.text, nama?.text, email?.text, image!);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
