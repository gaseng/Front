import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final String name;
  final String birth;
  final String addr;
  final String job;

  Customer({
    required this.name,
    required this.birth,
    required this.addr,
    required this.job,
  });

  factory Customer.fromJson(Map<String, dynamic> json)
  => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
