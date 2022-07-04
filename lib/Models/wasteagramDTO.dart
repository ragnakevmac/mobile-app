class WasteagramEntryFields {
  late String title;
  late String body;
  late int numWastedItems;
  late DateTime dateTime;

  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, numWastedItems: $numWastedItems';
  }
}