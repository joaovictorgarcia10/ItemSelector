import 'package:flutter/foundation.dart';
import 'package:topic_selector/model/contact_model.dart';

class AppController extends ChangeNotifier {
  List<ContactModel> contactsList = [
    ContactModel(name: "Bill Gates"),
    ContactModel(name: "Mark Zuckberg"),
    ContactModel(name: "Ellon Musk"),
    ContactModel(name: "Steve Jobs"),
    ContactModel(name: "Ozzy Osbourne"),
    ContactModel(name: "Jimmy Hendrix"),
    ContactModel(name: "Bruce Dickinson"),
    ContactModel(name: "Jeff Bezos"),
    ContactModel(name: "Flutter Dev"),
  ];

  List<ContactModel> searchList = [];
  List<ContactModel> selectedList = [];
  bool startSearch = false;

  setStartSearch({required bool value}) {
    startSearch = value;
    notifyListeners();
  }

  searchContact(
      {required List<ContactModel> listToSearch, required String pattern}) {
    searchList.clear();

    for (var item in listToSearch) {
      if (item.name.toLowerCase().contains(pattern.toLowerCase())) {
        if (!searchList.contains(item)) {
          searchList.add(item);
          notifyListeners();
        }
      }
    }
  }

  selectContact({required ContactModel contato}) {
    contato.isSelected = !contato.isSelected;
    notifyListeners();

    if (contato.isSelected == true) {
      if (!selectedList.contains(contato)) {
        selectedList.add(contato);
        notifyListeners();
      }
    } else {
      selectedList.remove(contato);
      notifyListeners();
    }
  }
}
