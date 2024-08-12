// ignore_for_file: file_names

class ServicesModel {
  final String serviceID;
  final String serviceImg;
  final String serviceName;

  ServicesModel({
    required this.serviceID,
    required this.serviceImg,
    required this.serviceName,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceID,
      'serviceImg': serviceImg,
      'serviceName': serviceName,
    };
  }

  // Create a UserModel instance from a JSON map
  factory ServicesModel.fromMap(Map<String, dynamic> json) {
    return ServicesModel(
      serviceID: json['serviceId'],
      serviceImg: json['serviceImg'],
      serviceName: json['serviceName'],
    );
  }
}
