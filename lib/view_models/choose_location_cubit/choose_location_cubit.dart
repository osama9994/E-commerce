import 'package:animation_project/models/location_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());
  void fetchLocations(){
    emit(FetchingLocations());
    Future.delayed(
      const Duration(seconds: 1),
    (){
      emit(FetchedLocations( dummyLacations));
    }
    );
  }

void addLocaton(String location){
  emit(AddingLocation());
  Future.delayed(
      const Duration(seconds: 1),
    (){
      final splittedLocations =location.split('-');
      final locationItem=LocationItemModel(
        id: DateTime.now().toIso8601String(),
         city: splittedLocations[0],
          country: splittedLocations[1],
         );
         dummyLacations.add(locationItem);
         emit(LocationAdded());
         emit(FetchedLocations(dummyLacations));
    }
    );

}

}
