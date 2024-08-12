// ignore_for_file: file_names

class ServicedetailModel {
  final String servicedID;
  final String serviceID;
  final String serviceName;
  final List servicedImg;
  final String serviceDescription;

  ServicedetailModel({
    required this.servicedID,
    required this.serviceID,
    required this.serviceName,
    required this.servicedImg,
    required this.serviceDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'servicedID': servicedID,
      'serviceID': serviceID,
      'serviceName': serviceName,
      'servicedImg': servicedImg,
      'serviceDescription': serviceDescription,
    };
  }

  factory ServicedetailModel.fromMap(Map<String, dynamic> json) {
    return ServicedetailModel(
      servicedID: json['servicedID'],
      serviceID: json['serviceID'],
      serviceName: json['serviceName'],
      servicedImg: json['servicedImg'],
      serviceDescription: json['serviceDescription'],
    );
  }
}
