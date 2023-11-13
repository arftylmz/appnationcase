import 'package:appnationcase/blocks/app_blocks.dart';
import 'package:appnationcase/blocks/app_events.dart';
import 'package:appnationcase/blocks/app_states.dart';
import 'package:appnationcase/data/repositories/request.dart';
import 'package:appnationcase/screens/homeScreen/home_screen_view.dart';
import 'package:appnationcase/screens/splashScreen/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const DogGenerateApp());
}
 class DogGenerateApp extends StatelessWidget {
  const DogGenerateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        primaryColor: Colors.white,
      ),*/
      home: RepositoryProvider(
        create: (context) => DogBreedRepository(),
        child: const Home(),
        
      ),
    );
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogBreedBloc(
        RepositoryProvider.of<DogBreedRepository>(context),
      )..add(LoadDogBreedEvent()),
      child: BlocBuilder<DogBreedBloc, DogBreedState>(
          builder: (context, state) {
            if(state is DogBreedLoadingState){
              return const SplashScreenView();
            }
            if(state is DogBreedLoadedState){
              
              return  HomeScreenView(dogBreedsList: state.dogBreeds,dogBreedsListPhoto: state.dogBreedsPhoto,);
            }
            return const SplashScreenView();
            }
      ));
  }
}