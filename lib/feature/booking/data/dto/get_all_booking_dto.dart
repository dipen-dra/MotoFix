import 'package:json_annotation/json_annotation.dart';

import '../model/booking_api_model.dart';

part 'get_all_booking_dto.g.dart';
@JsonSerializable()
class GetAllBookingDto{
  final bool success ;
  final String message ;
  final List<BookingApiModel> data ;

  GetAllBookingDto({
  required this.success ,
  required this.message ,
  required this.data
}) ;

  factory GetAllBookingDto.fromJson(Map<String , dynamic> json ) => _$GetAllBookingDtoFromJson(json) ;

  Map<String , dynamic> toJson() => _$GetAllBookingDtoToJson(this) ;


}