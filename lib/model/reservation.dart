class Reservation {
  final String date;
  final String email;
  final String id;
  final int numberTalbe;
  final bool status;
  final String time;
  final String type;
  Reservation(
      {required this.date,
      required this.email,
      required this.id,
      required this.numberTalbe,
      required this.status,
      required this.time,
      required this.type});
}
