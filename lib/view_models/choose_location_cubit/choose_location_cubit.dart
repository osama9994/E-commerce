import 'package:animation_project/models/location_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());
  String selectedLocationId = dummyLacations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(FetchedLocations(dummyLacations));
      },
    );
  }

  void addLocaton(String location) {
    emit(AddingLocation());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        final splittedLocations = location.split('-');
        final locationItem = LocationItemModel(
          id: DateTime.now().toIso8601String(),
          city: splittedLocations[0],
          country: splittedLocations[1],
        );
        dummyLacations.add(locationItem);
        emit(LocationAdded());
        emit(FetchedLocations(dummyLacations));
      },
    );
  }

  void selectedLocation(String id) {
    selectedLocationId = id;
    final chosenLocation =
        dummyLacations.firstWhere((location) => location.id == selectedLocationId);
    emit(LocationChosen(location: chosenLocation));
  }

  void confrimAdress() {
    emit(ConfrimAdressLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        var chosenAddress =
            dummyLacations.firstWhere((location) => location.id == selectedLocationId);
        var previousAddress = dummyLacations.firstWhere(
          (location) => location.isChosen == true,
          orElse: () => dummyLacations.first,
        );

        previousAddress = previousAddress.copyWith(isChosen: false);
        chosenAddress = chosenAddress.copyWith(isChosen: true);

        final previousIndex =
            dummyLacations.indexWhere((location) => location.id == previousAddress.id);
        final chosentIndex =
            dummyLacations.indexWhere((location) => location.id == chosenAddress.id);

        dummyLacations[previousIndex] = previousAddress;
        dummyLacations[chosentIndex] = chosenAddress;

        emit(ConfrimAdressLoaded());
      },
    );
  }
}
