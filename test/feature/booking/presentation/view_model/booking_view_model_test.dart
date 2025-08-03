import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/booking/domain/entity/booking_entity.dart';
import 'package:motofix_app/feature/booking/domain/use_case/create_user_bookings.dart';
import 'package:motofix_app/feature/booking/domain/use_case/delete_user_bookings.dart';
import 'package:motofix_app/feature/booking/domain/use_case/get_user_bookings.dart';
import 'package:motofix_app/feature/booking/presentation/view_model/booking_event.dart';
import 'package:motofix_app/feature/booking/presentation/view_model/booking_state.dart';
import 'package:motofix_app/feature/booking/presentation/view_model/booking_view_model.dart';

// --- Mocks and Fakes ---
class MockGetUserBookings extends Mock implements GetUserBookings {}
class MockCreateBookingUseCase extends Mock implements CreateBookingUseCase {}
class MockDeleteBookingUsecase extends Mock implements DeleteBookingUsecase {}
class FakeCreateBookingParams extends Fake implements CreateBookingParams {}

void main() {
  late BookingViewModel bookingViewModel;
  late MockGetUserBookings mockGetUserBookings;
  late MockCreateBookingUseCase mockCreateBookingUseCase;
  late MockDeleteBookingUsecase mockDeleteBookingUsecase;

  // --- Test Data ---
  final tBooking1 = BookingEntity(id: '1', bikeModel: 'R15', date: DateTime.now(), serviceType: 's1');
  final tBooking2 = BookingEntity(id: '2', bikeModel: 'Duke', date: DateTime.now(), serviceType: 's2');
  final tBookingsList = [tBooking1, tBooking2];
  const tFailure = ApiFailure(message: 'Server Error', statusCode: 500);

  setUpAll(() {
    registerFallbackValue(FakeCreateBookingParams());
  });

  setUp(() {
    mockGetUserBookings = MockGetUserBookings();
    mockCreateBookingUseCase = MockCreateBookingUseCase();
    mockDeleteBookingUsecase = MockDeleteBookingUsecase();
    bookingViewModel = BookingViewModel(
      getUserBookingsUseCase: mockGetUserBookings,
      createBookingUseCase: mockCreateBookingUseCase,
      deleteBookingUseCase: mockDeleteBookingUsecase,
    );
  });

  tearDown(() => bookingViewModel.close());

  test('initial state is BookingInitial', () {
    expect(bookingViewModel.state, isA<BookingInitial>());
  });

  group('LoadUserBookingsEvent', () {
    blocTest<BookingViewModel, BookingState>(
      'emits [BookingLoading, BookingLoadSuccess] when successful',
      setUp: () => when(() => mockGetUserBookings()).thenAnswer((_) async => Right(tBookingsList)),
      build: () => bookingViewModel,
      act: (bloc) => bloc.add(LoadUserBookingsEvent()),
      expect: () => <BookingState>[
        BookingLoading(),
        BookingLoadSuccess(tBookingsList),
      ],
      verify: (_) => verify(() => mockGetUserBookings()).called(1),
    );

    blocTest<BookingViewModel, BookingState>(
      'emits [BookingLoading, BookingFailure] when unsuccessful',
      setUp: () => when(() => mockGetUserBookings()).thenAnswer((_) async => const Left(tFailure)),
      build: () => bookingViewModel,
      act: (bloc) => bloc.add(LoadUserBookingsEvent()),
      expect: () => <BookingState>[
        BookingLoading(),
        BookingFailure(tFailure.message),
      ],
    );
  });

  group('CreateBookingEvent', () {
    // This test handles the chain of events: Create -> Reload
    blocTest<BookingViewModel, BookingState>(
      'emits [BookingActionSuccess, BookingLoading, BookingLoadSuccess] when creation and reload are successful',
      setUp: () {
        when(() => mockCreateBookingUseCase(any())).thenAnswer((_) async => const Right(null));
        // Stub the subsequent reload call
        when(() => mockGetUserBookings()).thenAnswer((_) async => Right(tBookingsList));
      },
      build: () => bookingViewModel,
      act: (bloc) => bloc.add(CreateBookingEvent(serviceId: 's1', bikeModel: 'Test Bike', date: DateTime.now())),
      expect: () => <BookingState>[
        const BookingActionSuccess('Booking Created Successfully!'),
        BookingLoading(),
        BookingLoadSuccess(tBookingsList),
      ],
      verify: (_) {
        verify(() => mockCreateBookingUseCase(any())).called(1);
        verify(() => mockGetUserBookings()).called(1);
      },
    );
  });
}