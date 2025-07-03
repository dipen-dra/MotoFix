
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';

abstract class BookingDataSource {
  Future<List<BookingEntity>> getUserBooking() ;
  Future<void> createBooking(BookingEntity entity) ;
  Future<void> deleteUserBooking(String bookingId , String? token) ;

}