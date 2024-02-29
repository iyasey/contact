import 'dart:io';

import 'package:contact1/model/contact_model.dart';
import 'package:contact1/provider/contact_Provider.dart';
import 'package:contact1/view/pages/contactsadd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends ConsumerWidget {
  ContactPage({super.key});
  final name = TextEditingController();
  final phone = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text("Contacts")),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => AddContacts(
                          image: null,
                          name: name,
                          phone: phone,
                          formkey: formkey,
                          onSubmit: () {
                            if (formkey.currentState!.validate()) {
                              ref.read(contactsProvider.notifier).addContact(
                                    ContactModel(
                                      imageFile: ref.watch(imageProvider) ==
                                              null
                                          ? null
                                          // ignore: dead_code
                                          : File(
                                              // ignore: null_check_always_fails
                                              ref.watch(imageProvider)!.path),
                                      name: name.text,
                                      phone: phone.text,
                                    ),
                                  );
                              name.clear();
                              phone.clear();
                              ref.read(imageProvider.notifier).state = null;
                              Navigator.pop(context);
                            }
                          },
                          onTapImage: () {
                            showDialog(
                                context: context,
                                builder: (builder) => AlertDialog(
                                      title: Text("Pick Image From"),
                                      content: Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () async {
                                              final imagepicker = ImagePicker();
                                              XFile? image =
                                                  await imagepicker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (image != null) {
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              }
                                              ref
                                                  .read(imageProvider.notifier)
                                                  .state = image;
                                            },
                                            icon: const Icon(Icons.camera),
                                            label: Text("Camera"),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              final imagePicker = ImagePicker();
                                              XFile? image =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (image != null) {
                                                Future.sync(() =>
                                                    Navigator.pop(context));
                                              }
                                              ref
                                                  .read(imageProvider.notifier)
                                                  .state = image;
                                            },
                                            icon: Icon(Icons.photo),
                                            label: Text("Gallery"),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                        ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text("Add a new contact"),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: contacts[index].imageFile == null
                            ? null
                            : FileImage(contacts[index].imageFile!),
                        child: contacts[index].imageFile == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(contacts[index].name),
                      subtitle: Text(contacts[index].phone),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => AddContacts(
                                          image: contacts[index].imageFile,
                                          name: name,
                                          phone: phone,
                                          formkey: formkey,
                                          onSubmit: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              ref
                                                  .read(
                                                      contactsProvider.notifier)
                                                  .editContact(
                                                    name.text,
                                                    phone.text,
                                                    index,
                                                    ref.watch(imageProvider) ==
                                                            null
                                                        ? null
                                                        : File(ref
                                                            .watch(
                                                                imageProvider)!
                                                            .path),
                                                  );
                                              name.clear();
                                              phone.clear();
                                              ref
                                                  .read(imageProvider.notifier)
                                                  .state = null;
                                              Navigator.pop(context);
                                            }
                                          },
                                          onTapImage: () {
                                            showDialog(
                                                context: context,
                                                builder: (builder) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          "Pick Image From"),
                                                      content: Row(
                                                        children: [
                                                          TextButton.icon(
                                                            onPressed:
                                                                () async {
                                                              final imagepicker =
                                                                  ImagePicker();
                                                              XFile? image =
                                                                  await imagepicker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              if (image !=
                                                                  null) {
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              }
                                                              ref
                                                                  .read(imageProvider
                                                                      .notifier)
                                                                  .state = image;
                                                            },
                                                            icon: const Icon(
                                                                Icons.camera),
                                                            label:
                                                                Text("Camera"),
                                                          ),
                                                          TextButton.icon(
                                                            onPressed:
                                                                () async {
                                                              final imagePicker =
                                                                  ImagePicker();
                                                              XFile? image =
                                                                  await imagePicker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              if (image !=
                                                                  null) {
                                                                Future.sync(() =>
                                                                    Navigator.pop(
                                                                        context));
                                                              }
                                                              ref
                                                                  .read(imageProvider
                                                                      .notifier)
                                                                  .state = image;
                                                            },
                                                            icon: Icon(
                                                                Icons.photo),
                                                            label:
                                                                Text("Gallery"),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                        ));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(contactsProvider.notifier)
                                    .deleteContact(index);
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  )),
    );
  }
}
