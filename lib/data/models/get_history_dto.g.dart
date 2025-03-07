// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetHistoryDtoImpl _$$GetHistoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$GetHistoryDtoImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetHistoryDtoImplToJson(_$GetHistoryDtoImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$DatumImpl _$$DatumImplFromJson(Map<String, dynamic> json) => _$DatumImpl(
      id: json['_id'] as String?,
      image: json['image'] as String?,
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num?)?.toDouble(),
      aiChats: json['ai_chats'] as List<dynamic>?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$DatumImplToJson(_$DatumImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'type': instance.type,
      'confidence': instance.confidence,
      'ai_chats': instance.aiChats,
      'created_at': instance.createdAt,
    };

_$TypeImpl _$$TypeImplFromJson(Map<String, dynamic> json) => _$TypeImpl(
      id: json['_id'] as String?,
      typeId: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameUz: json['name_uz'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$TypeImplToJson(_$TypeImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id': instance.typeId,
      'name': instance.name,
      'name_uz': instance.nameUz,
      'description': instance.description,
      'images': instance.images,
    };

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      totalRecords: (json['total_records'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'total_records': instance.totalRecords,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'next_page': instance.nextPage,
      'prev_page': instance.prevPage,
    };
