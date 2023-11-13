




import 'dart:convert';

import 'package:appnationcase/product/models/dog_breed_model.dart';
import 'package:appnationcase/product/models/dog_breed_random.dart';
import 'package:appnationcase/product/models/dog_photo_model.dart';
import 'package:http/http.dart';

class DogBreedRepository {
  String endpointBreds = 'https://dog.ceo/api/breeds';
  String endpointBred = 'https://dog.ceo/api/breed';

  Future<List<String>> getBreeds() async {
    Response response = await get(Uri.parse("$endpointBreds/list/all"));

    if (response.statusCode == 200) {
      // Başarılı cevap durumunda JSON'u çözerek geri dönebilirsiniz.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      DogBreedModel temp = DogBreedModel.fromJson(jsonResponse);
      return temp.message.keys.toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  Future<List<String>> getBreedPhoto(List<String> liste) async {
    List<String> dogPictureList = [];
    for(final e in liste){
      Response response = await get(Uri.parse("$endpointBred/$e/images"));

    if (response.statusCode == 200) {
      // Başarılı cevap durumunda JSON'u çözerek geri dönebilirsiniz.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
       dogPictureList.add(DogImageListModel.fromJson(jsonResponse).message.first);
    } else {
      throw Exception(response.reasonPhrase);
    }
    }
    return dogPictureList;
    }
    Future<String> getBreedRandom(String name) async {
    Response response = await get(Uri.parse("$endpointBred/$name/images/random"));
    if (response.statusCode == 200) {
      // Başarılı cevap durumunda JSON'u çözerek geri dönebilirsiniz.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return  DogImage.fromJson(jsonResponse).message;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}