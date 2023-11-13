
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable 
abstract class DogBreedEvent extends Equatable {
  const DogBreedEvent();
}

class LoadDogBreedEvent extends DogBreedEvent{
  @override
  List<Object> get props => [];
}