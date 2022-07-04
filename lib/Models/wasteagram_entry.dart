class WasteagramEntry {
  final String title;
  final String body; 
  final int rating;
  final DateTime dateTime;

  WasteagramEntry({required this.title, required this.body, required this.rating, required this.dateTime});
  
  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
  }
}