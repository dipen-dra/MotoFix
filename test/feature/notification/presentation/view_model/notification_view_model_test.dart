import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/notification/data/model/notification_model.dart';
import 'package:motofix_app/feature/notification/domain/use_case/get_notifications_usecase.dart';
import 'package:motofix_app/feature/notification/domain/use_case/mark_as_read_usecase.dart';
import 'package:motofix_app/feature/notification/presentation/view_model/notification_event.dart';
import 'package:motofix_app/feature/notification/presentation/view_model/notification_state.dart';
import 'package:motofix_app/feature/notification/presentation/view_model/notification_view_model.dart';

// --- Mocks for Dependencies ---
class MockGetNotificationsUseCase extends Mock implements GetNotificationsUseCase {}
class MockMarkAsReadUseCase extends Mock implements MarkAsReadUseCase {}

void main() {
  late NotificationViewModel notificationViewModel;
  late MockGetNotificationsUseCase mockGetNotificationsUseCase;
  late MockMarkAsReadUseCase mockMarkAsReadUseCase;

  // --- Test Data ---
  final tNotification1 = NotificationModel(id: '1', userId: 'u1', message: 'Msg 1', read: false, createdAt: DateTime.now());
  final tNotification2 = NotificationModel(id: '2', userId: 'u2', message: 'Msg 2', read: false, createdAt: DateTime.now());
  final tNotificationsList = [tNotification1, tNotification2];
  const tFailure = ApiFailure(message: 'API Error', statusCode: 500);

  setUp(() {
    mockGetNotificationsUseCase = MockGetNotificationsUseCase();
    mockMarkAsReadUseCase = MockMarkAsReadUseCase();
    notificationViewModel = NotificationViewModel(
      getNotificationsUseCase: mockGetNotificationsUseCase,
      markAsReadUseCase: mockMarkAsReadUseCase,
    );
  });

  tearDown(() => notificationViewModel.close());

  test('initial state is NotificationInitial', () {
    expect(notificationViewModel.state, isA<NotificationInitial>());
  });

  group('FetchNotifications Event', () {
    blocTest<NotificationViewModel, NotificationState>(
      'emits [Loading, Loaded] when fetching notifications is successful',
      setUp: () {
        when(() => mockGetNotificationsUseCase()).thenAnswer((_) async => Right(tNotificationsList));
      },
      build: () => notificationViewModel,
      act: (bloc) => bloc.add(FetchNotifications()),
      expect: () => [
        isA<NotificationLoading>(),
        // Use property matchers because NotificationModel is not Equatable
        isA<NotificationLoaded>()
            .having((state) => state.notifications.length, 'number of notifications', tNotificationsList.length)
            .having((state) => state.notifications.first.id, 'first notification id', tNotification1.id),
      ],
      verify: (_) => verify(() => mockGetNotificationsUseCase()).called(1),
    );

    blocTest<NotificationViewModel, NotificationState>(
      'emits [Loading, Error] when fetching notifications fails',
      setUp: () {
        when(() => mockGetNotificationsUseCase()).thenAnswer((_) async => const Left(tFailure));
      },
      build: () => notificationViewModel,
      act: (bloc) => bloc.add(FetchNotifications()),
      expect: () => <NotificationState>[
        NotificationLoading(),
        NotificationError(message: tFailure.message),
      ],
      verify: (_) => verify(() => mockGetNotificationsUseCase()).called(1),
    );
  });

  group('MarkNotificationsAsRead Event', () {
    blocTest<NotificationViewModel, NotificationState>(
      'triggers a refetch, emitting [Loading, Loaded] on success',
      setUp: () {
        // Arrange for BOTH use cases in the chain
        when(() => mockMarkAsReadUseCase()).thenAnswer((_) async => const Right(null));
        when(() => mockGetNotificationsUseCase()).thenAnswer((_) async => Right(tNotificationsList));
      },
      build: () => notificationViewModel,
      act: (bloc) => bloc.add(MarkNotificationsAsRead()),
      expect: () => [
        isA<NotificationLoading>(),
        isA<NotificationLoaded>()
            .having((state) => state.notifications.length, 'number of notifications', tNotificationsList.length),
      ],
      verify: (_) {
        // Verify both use cases were called in order
        verifyInOrder([
          () => mockMarkAsReadUseCase(),
          () => mockGetNotificationsUseCase(),
        ]);
      },
    );

    blocTest<NotificationViewModel, NotificationState>(
      'emits nothing when marking as read fails',
      setUp: () {
        // Arrange for the markAsReadUseCase to fail
        when(() => mockMarkAsReadUseCase()).thenAnswer((_) async => const Left(tFailure));
      },
      build: () => notificationViewModel,
      act: (bloc) => bloc.add(MarkNotificationsAsRead()),
      // Expect an empty list because your BLoC's failure block is empty
      expect: () => [],
      verify: (_) {
        // Verify only the first use case was called
        verify(() => mockMarkAsReadUseCase()).called(1);
        // Verify the second use case was NEVER called
        verifyNever(() => mockGetNotificationsUseCase());
      },
    );
  });
}