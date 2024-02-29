import 'dart:io';

import 'package:contact1/model/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    return [];
  }

  void addContact(ContactModel contactModel) {
    state = [contactModel, ...state];
  }

  void deleteContact(int index) {
    final delete = state;
    delete.removeAt(index);
    state = List.from(delete);
  }

  void editContact(String name, String phone, int index, File? image) {
    final contacts = state;
    contacts[index] =
        contacts[index].CopyWith(name: name, phone: phone, imageFile: image);
    state = List.from(contacts);
  }
}

final contactsProvider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);
final imageProvider = StateProvider<XFile?>((ref) => null);
