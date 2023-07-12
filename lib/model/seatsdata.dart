class SeatData {
  String status;
  String seatNo;
  String id;
  dynamic ticketTicketNumber;

  SeatData(
      {required this.status,
      required this.seatNo,
      required this.id,
      this.ticketTicketNumber});

  factory SeatData.fromJson(Map<String, dynamic> json) {
    return SeatData(
      status: json['status'],
      seatNo: json['seat_no'],
      id: json['id'],
      ticketTicketNumber: json['ticketTicketNumber'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['seat_no'] = this.seatNo;
  //   data['id'] = this.id;
  //   data['ticketTicketNumber'] = this.ticketTicketNumber;
  //   return data;
  // }
}
