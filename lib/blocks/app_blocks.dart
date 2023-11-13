

import 'package:appnationcase/blocks/app_events.dart';
import 'package:appnationcase/blocks/app_states.dart';
import 'package:appnationcase/data/repositories/request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogBreedBloc extends Bloc<DogBreedEvent, DogBreedState>{
  final DogBreedRepository _dogBreedRepository;

  DogBreedBloc(this._dogBreedRepository) : super (DogBreedLoadingState()){
    on<LoadDogBreedEvent>((event, emit) async {
      emit(DogBreedLoadingState());
      try{
        final dogBreeds = await _dogBreedRepository.getBreeds();
        final dogBreedsPhoto = await _dogBreedRepository.getBreedPhoto(dogBreeds);
        emit(DogBreedLoadedState(dogBreeds,dogBreedsPhoto));
      }catch(e) {
        emit(DogBreedErrorState(e.toString()));
      }
      
      
    });
  }
}