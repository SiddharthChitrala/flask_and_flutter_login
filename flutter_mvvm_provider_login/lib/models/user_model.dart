
import 'package:flutter_mvvm_provider_login/models/address_info_model.dart';

class UserModel extends AddressInfo{
  
  String? userIdentifier;
  String? otp;
  String? name;
  String? userType; // USER, ADMIN, APPROVER, VENDOR
  String? businessName; // Only for VENDOR
  String? gstNumber; // Only for VENDOR
  AddressInfo? addressInfo; // Only for VENDOR

  UserModel({
    this.userIdentifier,
    this.otp,
    this.name,
    this.userType,
    this.businessName,
    this.gstNumber,
    this.addressInfo,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userIdentifier = json['userIdentifier'];
    otp = json['otp'];
    name = json['name'];
    userType = json['userType'];
    businessName = json['businessName'];
    gstNumber = json['gstNumber'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userIdentifier'] = userIdentifier;
    data['otp'] = otp;
    data['name'] = name;
    data['userType'] = userType;
    if (businessName != null) {
      data['businessName'] = businessName;
    }
    if (gstNumber != null) {
      data['gstNumber'] = gstNumber;
    }
    if (addressInfo != null) {
      data['addressInfo'] = addressInfo!.toJson();
    }
    return data;
  }
}
