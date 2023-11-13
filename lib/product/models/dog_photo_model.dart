class DogImageListModel {
  final List<String> message;
  final String status;

  DogImageListModel({
    required this.message,
    required this.status,
  });

  factory DogImageListModel.fromJson(Map<String, dynamic> json) {
    return DogImageListModel(
      message: List<String>.from(json['message']),
      status: json['status'],
    );
  }
}