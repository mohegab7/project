import 'package:json_annotation/json_annotation.dart';
import 'fdc_food_dto.dart';

part 'fdc_word_response_dto.g.dart';

@JsonSerializable()
class FDCWordResponseDTO {
  final List<FDCFoodDTO> foods;

  FDCWordResponseDTO({required this.foods, int? totalHits, int? currentPage});

  factory FDCWordResponseDTO.fromJson(Map<String, dynamic> json) {
    return FDCWordResponseDTO(
      foods: (json['foods'] as List<dynamic>?)
              ?.map((item) => FDCFoodDTO.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [], // إرجاع قائمة فارغة إذا كانت null
    );
  }

  get currentPage => null;

  get totalHits => null;

  Map<String, dynamic> toJson() => _$FDCWordResponseDTOToJson(this);
}
