import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/notification/data/model/notification_model.dart';
import 'package:motofix_app/feature/notification/domain/repository/notification_repository.dart';
import 'package:motofix_app/feature/notification/domain/use_case/get_notifications_usecase.dart';

// Mock from a separate file
class MockNotificationRepository extends Mock implements INotificationRepository {}

void main() {
  late GetNotificationsUseCase usecase;
  late MockNotificationRepository mockNotificationRepository;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    usecase = GetNotificationsUseCase(repository: mockNotificationRepository);
  });

  // Sample data that matches your actual NotificationModel structure
  final tNotificationsList = [
    NotificationModel(
      id: '1',
      userId: 'user-abc',
      message: 'Your service appointment is confirmed.',
      read: false,
      createdAt: DateTime(2025, 8, 2),
    ),
    NotificationModel(
      id: '2',
      userId: 'user-xyz',
      message: 'We have received your payment.',
      read: true,
      createdAt: DateTime(2025, 8, 1),
    ),
  ];

  const tServerFailure = ServerFailure(message: 'Could not connect to the server');

  group('GetNotificationsUseCase', () {
    test(
      'should get list of notifications from the repository successfully',
      () async {
        // Arrange
        // Stub the repository to return a successful result with the notifications list
        when(() => mockNotificationRepository.getNotifications())
            .thenAnswer((_) async => Right(tNotificationsList));

        // Act
        // Execute the use case
        final result = await usecase();

        // Assert
        // STEP 1: Verify the repository was called.
        verify(() => mockNotificationRepository.getNotifications()).called(1);

        // STEP 2: Use fold to safely access the result.
        result.fold(
          // This `left` side of the fold should not be called in a success test.
          (failure) => fail('Expected a list of notifications, but got a Failure'),
          // This `right` side of the fold contains our list.
          (actualList) {
            // STEP 3: Verify the properties of the list.
            expect(actualList, isA<List<NotificationModel>>());
            expect(actualList.length, tNotificationsList.length);
            // Check some key properties to ensure the data is correct.
            expect(actualList[0].id, tNotificationsList[0].id);
            expect(actualList[0].message, tNotificationsList[0].message);
            expect(actualList[1].userId, tNotificationsList[1].userId);
            expect(actualList[1].read, tNotificationsList[1].read);
          },
        );
        
        // STEP 4: Ensure no other methods were called on the mock.
        verifyNoMoreInteractions(mockNotificationRepository);
      },
    );

    test(
      'should return a Failure when the repository fails',
      () async {
        // Arrange
        // This test remains the same as it does not depend on model equality.
        when(() => mockNotificationRepository.getNotifications())
            .thenAnswer((_) async => const Left(tServerFailure));

        // Act
        final result = await usecase();

        // Assert
        expect(result, const Left(tServerFailure));
        verify(() => mockNotificationRepository.getNotifications()).called(1);
        verifyNoMoreInteractions(mockNotificationRepository);
      },
    );
  });
}