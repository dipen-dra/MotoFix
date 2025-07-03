// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBookingDto _$GetAllBookingDtoFromJson(Map<String, dynamic> json) =>
    GetAllBookingDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => BookingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBookingDtoToJson(GetAllBookingDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
