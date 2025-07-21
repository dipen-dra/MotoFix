// data/model/booking_api_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? customerName;
  final String? serviceType;
  final String? bikeModel;
  final DateTime? date;
  final String? notes;
  final double? totalCost;
  final String? status;
  final String? paymentStatus;
  final bool? isPaid;
  final String? paymentMethod;

  BookingApiModel({
    this.id,
    this.customerName,
    this.serviceType,
    this.bikeModel,
    this.date,
    this.notes,
    this.totalCost,
    this.status,
    this.paymentStatus,
    this.isPaid,
    this.paymentMethod,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

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

  factory BookingApiModel.fromEntity(BookingEntity entity) {
    return BookingApiModel(
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
  }

  static List<BookingEntity> toEntityList(List<BookingApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
