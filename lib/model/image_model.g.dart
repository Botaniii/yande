// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      (json['id'] as num?)?.toInt(),
      json['tags'] as String?,
      (json['created_at'] as num?)?.toInt(),
      (json['updated_at'] as num?)?.toInt(),
      (json['creator_id'] as num?)?.toInt(),
      json['author'] as String?,
      (json['change'] as num?)?.toInt(),
      json['source'] as String?,
      (json['score'] as num?)?.toInt(),
      json['md5'] as String?,
      (json['file_size'] as num?)?.toInt(),
      json['file_ext'] as String?,
      json['file_url'] as String?,
      json['is_shown_in_index'] as bool?,
      json['preview_url'] as String?,
      (json['preview_width'] as num?)?.toInt(),
      (json['preview_height'] as num?)?.toInt(),
      (json['actual_preview_width'] as num?)?.toInt(),
      (json['actual_preview_height'] as num?)?.toInt(),
      json['sample_url'] as String?,
      (json['sample_width'] as num?)?.toInt(),
      (json['sample_height'] as num?)?.toInt(),
      (json['sample_file_size'] as num?)?.toInt(),
      json['jpeg_url'] as String?,
      (json['jpeg_width'] as num?)?.toInt(),
      (json['jpeg_height'] as num?)?.toInt(),
      (json['jpeg_file_size'] as num?)?.toInt(),
      json['rating'] as String?,
      json['is_rating_locked'] as bool?,
      json['has_children'] as bool?,
      json['status'] as String?,
      json['is_pending'] as bool?,
      (json['width'] as num?)?.toInt(),
      (json['height'] as num?)?.toInt(),
      json['is_held'] as bool?,
      json['frames_pending_string'] as String?,
      json['frames_pending'] as List<dynamic>?,
      json['frames_string'] as String?,
      json['frames'] as List<dynamic>?,
      json['is_note_locked'] as bool?,
      (json['last_noted_at'] as num?)?.toInt(),
      (json['last_commented_at'] as num?)?.toInt(),
    )
      ..tagTagModelList = (json['tagTagModelList'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..pages = (json['pages'] as num?)?.toInt()
      ..collectStatus = $enumDecodeNullable(
          _$ImageCollectStatusEnumMap, json['collect_status'])
      ..downloadStatus = $enumDecodeNullable(
          _$ImageDownloadStatusEnumMap, json['download_status'])
      ..downloadPath = json['download_path'] as String?
      ..dataSourceName = json['dataSourceName'] as String?;

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'tagTagModelList': instance.tagTagModelList,
      'pages': instance.pages,
      'collect_status': _$ImageCollectStatusEnumMap[instance.collectStatus],
      'download_status': _$ImageDownloadStatusEnumMap[instance.downloadStatus],
      'download_path': instance.downloadPath,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'creator_id': instance.creatorId,
      'author': instance.author,
      'change': instance.change,
      'source': instance.source,
      'score': instance.score,
      'md5': instance.md5,
      'file_size': instance.fileSize,
      'file_ext': instance.fileExt,
      'file_url': instance.fileUrl,
      'is_shown_in_index': instance.isShownInIndex,
      'preview_url': instance.previewUrl,
      'preview_width': instance.previewWidth,
      'preview_height': instance.previewHeight,
      'actual_preview_width': instance.actualPreviewWidth,
      'actual_preview_height': instance.actualPreviewHeight,
      'sample_url': instance.sampleUrl,
      'sample_width': instance.sampleWidth,
      'sample_height': instance.sampleHeight,
      'sample_file_size': instance.sampleFileSize,
      'jpeg_url': instance.jpegUrl,
      'jpeg_width': instance.jpegWidth,
      'jpeg_height': instance.jpegHeight,
      'jpeg_file_size': instance.jpegFileSize,
      'rating': instance.rating,
      'is_rating_locked': instance.isRatingLocked,
      'has_children': instance.hasChildren,
      'status': instance.status,
      'is_pending': instance.isPending,
      'width': instance.width,
      'height': instance.height,
      'is_held': instance.isHeld,
      'frames_pending_string': instance.framesPendingString,
      'frames_pending': instance.framesPending,
      'frames_string': instance.framesString,
      'frames': instance.frames,
      'is_note_locked': instance.isNoteLocked,
      'last_noted_at': instance.lastNotedAt,
      'last_commented_at': instance.lastCommentedAt,
      'dataSourceName': instance.dataSourceName,
    };

const _$ImageCollectStatusEnumMap = {
  ImageCollectStatus.star: 0,
  ImageCollectStatus.unStar: 1,
};

const _$ImageDownloadStatusEnumMap = {
  ImageDownloadStatus.none: 0,
  ImageDownloadStatus.pending: 1,
  ImageDownloadStatus.success: 2,
  ImageDownloadStatus.error: 3,
};
