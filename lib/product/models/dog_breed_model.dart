class DogBreedModel {
  final Map<String, List<String>> message;
  final String status;

  DogBreedModel({
    required this.message,
    required this.status,
  });

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
  Map<String, dynamic> message = json['message'];
  Map<String, List<String>> typedMessage = {};

  // message içindeki her bir key-value çiftini döngü ile geçelim
  message.forEach((key, value) {
    // Eğer değer bir liste ise, doğrudan atama yapalım
    if (value is List) {
      typedMessage[key] = List<String>.from(value);
    } else {
      // Değer bir liste değilse, boş bir liste ile başlayan bir map olarak ele alalım
      typedMessage[key] = [];
    }
  });

  return DogBreedModel(
    message: typedMessage,
    status: json['status'],
  );
}
/*List<String> getAllBreeds() {
    List<String> allBreeds = [];

    // Her bir anahtarın içindeki listeleri döngü ile geçelim
    message.forEach((key, value) {
      // Eğer liste boş değilse, her bir öğeyi anahtar ile birleştirip listeye ekleyelim
      if (value.isNotEmpty) {
        value.forEach((item) {
          allBreeds.add("$item $key");
        });
      }else{

      }
    });

    return allBreeds;
  }*/

}
