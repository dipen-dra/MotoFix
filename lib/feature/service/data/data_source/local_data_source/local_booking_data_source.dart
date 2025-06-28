import 'package:motofix_app/core/network/hive_service.dart';
import 'package:motofix_app/feature/service/data/data_source/booking_data_source.dart';
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';

class LocalBookingDataSource implements BookingDataSource {
  final HiveService _hiveService ;
  
  LocalBookingDataSource({
    required HiveService hiveService
}) :  _hiveService = hiveService ;

  @override
  Future<void> createBooking(BookingEntity entity) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserBooking(String bookingId, String? token) {
    // TODO: implement deleteUserBooking
    throw UnimplementedError();
  }

  @override
  Future<List<BookingEntity>> getUserBooking() {
    // TODO: implement getUserBooking
    throw UnimplementedError();
  }
  
}