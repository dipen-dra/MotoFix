import 'package:dio/dio.dart';
import 'package:motofix_app/app/constant/api_endpoints.dart';
import 'package:motofix_app/core/network/api_service.dart';
import 'package:motofix_app/core/network/dio_error_interceptor.dart';
import 'package:motofix_app/feature/service/data/data_source/booking_data_source.dart';
import 'package:motofix_app/feature/service/data/dto/get_all_booking_dto.dart';
import 'package:motofix_app/feature/service/data/model/booking_api_model.dart';
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';

class RemoteBookingDataSource implements BookingDataSource {
  final ApiService _apiService;
  RemoteBookingDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<void> createBooking(BookingEntity entity) async {
    try {
      final bookingApiModel = BookingApiModel.fromEntity(entity);
      var response = await _apiService.dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to add batch: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to add batch: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred : $e}');
    }
  }

  @override
  Future<void> deleteUserBooking(String bookingId, String? token) async {
    try {
      final response = await _apiService.dio.delete(
        '${ApiEndpoints.deleteBooking}/$bookingId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to delete booking : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to delete bookings: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete Bookings : $e');
    }
  }

  @override
  Future<List<BookingEntity>> getUserBooking() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllBooking);
      print("All booking user $response");

      if (response.statusCode == 200) {
        GetAllBookingDto getAllBookingDto =
            GetAllBookingDto.fromJson(response.data);
        return BookingApiModel.toEntityList(getAllBookingDto.data);
      } else {
        throw Exception('Failed to fetch bookings  :${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception("failed to booking : ${e.message} ");
    } catch (e) {
      throw Exception('An unexpected error occured : $e');
    }
  }
}
