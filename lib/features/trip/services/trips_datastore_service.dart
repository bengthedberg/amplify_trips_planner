import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tripsDataStoreServiceProvider = Provider<TripsDataStoreService>((ref) {
  final service = TripsDataStoreService();
  return service;
});

class TripsDataStoreService {
  TripsDataStoreService();

  // listenToTrips - This function will query the Amplify DataStore for the
  // active and upcoming trips and stream a list of them.
  Stream<List<Trip>> listenToTrips() {
    return Amplify.DataStore.observeQuery(
      Trip.classType,
      sortBy: [Trip.STARTDATE.ascending()],
    )
        .map((event) => event.items
            .where((element) =>
                element.endDate.getDateTime().isAfter(DateTime.now()))
            .toList())
        .handleError(
      (error) {
        debugPrint('listenToTrips: A Stream error happened');
      },
    );
  }

  // listenToPastTrips - This function will query the Amplify DataStore for
  // past trips and stream a list of them.
  Stream<List<Trip>> listenToPastTrips() {
    return Amplify.DataStore.observeQuery(
      Trip.classType,
      sortBy: [Trip.STARTDATE.ascending()],
    )
        .map((event) => event.items
            .where((element) =>
                element.endDate.getDateTime().isBefore(DateTime.now()))
            .toList())
        .handleError(
      (error) {
        debugPrint('listenToTrips: A Stream error happened');
      },
    );
  }

  // getTripStream - This function will query the Amplify DataStore for a
  // specific trip and stream a list of that.
  Stream<Trip> getTripStream(String id) {
    final tripStream =
        Amplify.DataStore.observeQuery(Trip.classType, where: Trip.ID.eq(id))
            .map((event) => event.items.toList().single);

    return tripStream;
  }

  // addTrip - Is for adding a trip in the Amplify DataStore.
  Future<void> addTrip(Trip trip) async {
    try {
      await Amplify.DataStore.save(trip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  // deleteTrip - Is for deleting a trip in the Amplify DataStore.
  Future<void> deleteTrip(Trip trip) async {
    try {
      await Amplify.DataStore.delete(trip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  // updateTrip - Is for updating a trip in the Amplify DataStore.
  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      final tripsWithId = await Amplify.DataStore.query(
        Trip.classType,
        where: Trip.ID.eq(updatedTrip.id),
      );

      final oldTrip = tripsWithId.first;
      final newTrip = oldTrip.copyWith(
        tripName: updatedTrip.tripName,
        destination: updatedTrip.destination,
        startDate: updatedTrip.startDate,
        endDate: updatedTrip.endDate,
        tripImageKey: updatedTrip.tripImageKey,
        tripImageUrl: updatedTrip.tripImageUrl,
      );

      await Amplify.DataStore.save(newTrip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
