import 'package:json_annotation/json_annotation.dart';
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel {
  @JsonKey(name: "_id")
  final String? id;
  final String customerName;
  final String serviceType;
  final String bikeModel;
  // This is the key fix: Tell JSON serializer how to handle the date
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime date;
  final String? notes;
  final double totalCost;
  final String status;
  final String paymentStatus;
  final bool isPaid;
  final String? paymentMethod;

  BookingApiModel({
    this.id,
    required this.customerName,
    required this.serviceType,
    required this.bikeModel,
    required this.date,
    this.notes,
    required this.totalCost,
    required this.status,
    required this.paymentStatus,
    required this.isPaid,
    this.paymentMethod,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  // Helper functions for date conversion
  static DateTime _dateTimeFromJson(String date) => DateTime.parse(date);
  static String _dateTimeToJson(DateTime date) => date.toIso8601String();


  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      customerName: customerName,
      serviceType: serviceType,
      bikeModel: bikeModel,
      date: date,
      notes: notes,
      totalCost: totalCost,
      status: status,
      paymentStatus: paymentStatus,
      isPaid: isPaid,
      paymentMethod: paymentMethod,
    );
  }

  // Corrected and completed fromEntity method
  static BookingApiModel fromEntity(BookingEntity entity) => BookingApiModel(
    id: entity.id,
    customerName: entity.customerName,
    serviceType: entity.serviceType,
    bikeModel: entity.bikeModel,
    date: entity.date,
    notes: entity.notes,
    totalCost: entity.totalCost,
    status: entity.status,
    paymentStatus: entity.paymentStatus,
    isPaid: entity.isPaid,
    paymentMethod: entity.paymentMethod,
  );

  static List<BookingEntity> toEntityList(List<BookingApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}