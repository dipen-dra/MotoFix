import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motofix_app/feature/customer_service/domain/entity/service_entity.dart';

part 'service_api_model.g.dart';
@JsonSerializable()
class ServiceApiModel extends Equatable {
  @JsonKey(name : '_id')
  final String? serviceId ;

  final String name ;
  final String description ;
  final double price ;
  final String? duration ;

  ServiceApiModel({
    this.serviceId ,
    required this.name ,
    required this.description ,
    required this.price ,
    this.duration ,
  }) ;

  @override
  // TODO: implement props
  List<Object?> get props => [serviceId , name , description , price , duration];

  const ServiceApiModel.empty()
   : serviceId = "" ,
  name = "" ,
  description = "" ,
  price = 0,
  duration = "" ;

  factory ServiceApiModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceApiModelToJson(this);

  ServiceEntity toEntity() {
    return ServiceEntity(
      name: name ?? 'Unnamed Service',
      description: description ?? 'No description available.',
      price: price ?? 0.0, // Provide a default
      duration: duration ?? 'N/A',
    );
  }

  static ServiceEntity fromEntity(ServiceEntity entity){
    return ServiceEntity(name: entity.name, description: entity.description, price: entity.price, duration: entity.duration) ;
  }

  static List<ServiceEntity> toEntityList(
      List<ServiceApiModel> models,
      ) {
    return models.map((model) => model.toEntity()).toList();
  }



}