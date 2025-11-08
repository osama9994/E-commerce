part of 'choose_location_cubit.dart';


sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}
final class FetchingLocations extends ChooseLocationState {}
final class FetchedLocations extends ChooseLocationState {
  final List<LocationItemModel> locations;
  FetchedLocations(this.locations);
}
final class FetchLocationFailure extends ChooseLocationState {
  final String errorMessage;
  FetchLocationFailure({required this.errorMessage});
}


final class AddingLocation extends ChooseLocationState {}
final class LocationAdded extends ChooseLocationState {
 
}
final class LocationAddednFailure extends ChooseLocationState {
  final String errorMessage;
  LocationAddednFailure({required this.errorMessage});
}

final class LocationChosen extends ChooseLocationState {
  final LocationItemModel location;
  LocationChosen({required this.location});
}



final class ConfrimAdressLoading extends ChooseLocationState {}
final class ConfrimAdressLoaded extends ChooseLocationState {
 
}
final class ConfrimAdressFailure extends ChooseLocationState {
  final String errorMessage;
  ConfrimAdressFailure({required this.errorMessage});
}