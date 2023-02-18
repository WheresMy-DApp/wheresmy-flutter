class DeviceType {
  String type;
  String name;

  DeviceType({
    required this.type,
    required this.name,
  });

  factory DeviceType.fromJson(Map<String, dynamic> json) {
    return DeviceType(
      type: json['type'],
      name: json['name'],
    );
  }
}

class Device {
  String id;
  String createdAt;
  String owner;
  String deviceNickname;
  DeviceType deviceType;
  bool isLost;
  String deviceHash;

  Device({
    required this.id,
    required this.createdAt,
    required this.owner,
    required this.deviceNickname,
    required this.deviceType,
    required this.isLost,
    required this.deviceHash,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      createdAt: json['createdAt'],
      owner: json['owner'],
      deviceNickname: json['deviceNickname'],
      deviceType: DeviceType.fromJson(json['deviceType']),
      isLost: json['isLost'],
      deviceHash: json['deviceHash'],
    );
  }
}
