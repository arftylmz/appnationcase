import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable 
abstract class DogBreedState extends Equatable {}

class DogBreedLoadingState extends DogBreedState{
  @override
  List<Object?> get props => [];
}
class DogBreedLoadedState extends DogBreedState{
  final List<String> dogBreeds;
  final List<String> dogBreedsPhoto;
  DogBreedLoadedState(this.dogBreeds,this.dogBreedsPhoto);
  @override
  List<Object?> get props => [dogBreeds,dogBreedsPhoto];
}
class DogBreedErrorState extends DogBreedState{
  DogBreedErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}