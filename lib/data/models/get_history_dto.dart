import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_history_dto.freezed.dart';
part 'get_history_dto.g.dart';

@freezed
class GetHistoryDto with _$GetHistoryDto {
    const factory GetHistoryDto({
        @JsonKey(name: "data")
        List<Datum>? data,
        @JsonKey(name: "pagination")
        Pagination? pagination,
    }) = _GetHistoryDto;

    factory GetHistoryDto.fromJson(Map<String, dynamic> json) => _$GetHistoryDtoFromJson(json);
}

@freezed
class Datum with _$Datum {
    const factory Datum({
        @JsonKey(name: "_id")
        String? id,
        @JsonKey(name: "image")
        String? image,
        @JsonKey(name: "type")
        Type? type,
        @JsonKey(name: "confidence")
        double? confidence,
        @JsonKey(name: "ai_chats")
        List<dynamic>? aiChats,
        @JsonKey(name: "created_at")
        String? createdAt,
    }) = _Datum;

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

@freezed
class Type with _$Type {
    const factory Type({
        @JsonKey(name: "_id")
        String? id,
        @JsonKey(name: "id")
        int? typeId,
        @JsonKey(name: "name")
        String? name,
        @JsonKey(name: "name_uz")
        String? nameUz,
        @JsonKey(name: "description")
        String? description,
        @JsonKey(name: "images")
        List<String>? images,
    }) = _Type;

    factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}

@freezed
class Pagination with _$Pagination {
    const factory Pagination({
        @JsonKey(name: "total_records")
        int? totalRecords,
        @JsonKey(name: "current_page")
        int? currentPage,
        @JsonKey(name: "total_pages")
        int? totalPages,
        @JsonKey(name: "next_page")
        dynamic nextPage,
        @JsonKey(name: "prev_page")
        dynamic prevPage,
    }) = _Pagination;

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}
