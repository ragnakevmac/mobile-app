import 'package:wasteagram/Models/wasteagram_entry.dart';

class Wasteagram {

  List<WasteagramEntry> entries = [];
  
  Wasteagram({required this.entries});


  void addEntry(entry) {
    entries == null ? entries = [entry] : entries.add(entry);
  }

  map(Function(dynamic e) param0) {}

}