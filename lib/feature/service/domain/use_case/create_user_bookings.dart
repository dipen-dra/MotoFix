    import 'package:dartz/dartz.dart';
    import 'package:equatable/equatable.dart';
    import 'package:motofix_app/app/usecase/usecase.dart';
    import 'package:motofix_app/core/error/failure.dart';
    import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';
    import 'package:motofix_app/feature/service/domain/repository/booking_repository.dart';

    class CreateBookingParams extends Equatable {
      final String? id ;
      final String customerName;
      final String serviceType;
      final String bikeModel;
      final DateTime date;
      final String? notes;
      final double totalCost;
      final String status; // 'Pending', 'Confirmed', 'Completed', 'Cancelled'
      final String paymentStatus; // 'Pending', 'Paid'
      final bool isPaid;
      final String? paymentMethod;

      CreateBookingParams({
        this.id ,
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

    }) ;

      @override
      // TODO: implement props
      List<Object?> get props => [customerName , serviceType , bikeModel , date ,notes , totalCost , status , paymentMethod , paymentStatus ,isPaid];




    }
    class CreateBookingUseCase implements UseCaseWithParams<void, CreateBookingParams> {
      final BookingRepository bookingRepository;

      CreateBookingUseCase({required this.bookingRepository});

      @override
      Future<Either<Failure, void>> call(CreateBookingParams params) async {
        // Create the entity from the params provided by the ViewModel
        final bookingEntity = BookingEntity(
          id: params.id,
          // Fixed: removed the unnecessary '!'
          customerName: params.customerName,
          serviceType: params.serviceType,
          bikeModel: params.bikeModel,
          date: params.date,
          notes: params.notes,
          totalCost: params.totalCost,
          status: params.status,
          paymentStatus: params.paymentStatus,
          isPaid: params.isPaid,
          paymentMethod: params.paymentMethod,
        );
        // Call the repository method
        return await bookingRepository.createBooking(bookingEntity);
      }

    }