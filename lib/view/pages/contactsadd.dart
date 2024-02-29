import 'dart:io';

import 'package:contact1/provider/contact_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContacts extends StatelessWidget {
  final TextEditingController name;
  final File? image;
  final TextEditingController phone;
  final GlobalKey<FormState> formkey;
  final void Function() onSubmit;
  final VoidCallback onTapImage;
  const AddContacts(
      {super.key,
      required this.name,
      required this.image,
      required this.phone,
      required this.formkey,
      required this.onSubmit,
      required this.onTapImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: onTapImage,
                  child: Stack(children: [
                    Consumer(builder: (_, ref, __) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: ref.watch(imageProvider) == null
                            ? image == null
                                ? null
                                : FileImage(image!)
                            : FileImage(File(ref.watch(imageProvider)!.path)),
                        child: ref.watch(imageProvider) == null
                            ? image == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )
                                : null
                            : null,
                      );
                    }),
                  ]),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter a name";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "PhoneNumber"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter a phone number";
                  }
                  if (value.length < 10) {
                    return "enter a valid phone number";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(onPressed: onSubmit, child: const Text("Save")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
