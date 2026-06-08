class GroupPost {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String groupId;
  final String groupName;
  final String? imageUrl;
  final String? caption;
  final String audience;
  final int likesCount;
  final int commentsCount;
  final bool likedByMe;
  final bool isOwn;
  final String createdAt;

  const GroupPost({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.groupId,
    required this.groupName,
    this.imageUrl,
    this.caption,
    required this.audience,
    required this.likesCount,
    required this.commentsCount,
    required this.likedByMe,
    required this.isOwn,
    required this.createdAt,
  });

  factory GroupPost.fromJson(Map<String, dynamic> json) => GroupPost(
        id:            json['id']?.toString() ?? '',
        userId:        json['user_id']?.toString() ?? '',
        userName:      json['user_name']?.toString() ?? 'User',
        userPhotoUrl:  json['user_photo']?.toString(),
        groupId:       json['group_id']?.toString() ?? '',
        groupName:     json['group_name']?.toString() ?? '',
        imageUrl:      json['image_url']?.toString(),
        caption:       json['caption']?.toString(),
        audience:      json['audience']?.toString() ?? 'group',
        likesCount:    (json['likes_count'] as num?)?.toInt() ?? 0,
        commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
        likedByMe:     json['liked_by_me'] == true,
        isOwn:         json['is_own'] == true,
        createdAt:     json['created_at']?.toString() ?? '',
      );

  GroupPost copyWith({int? likesCount, bool? likedByMe, int? commentsCount}) => GroupPost(
        id:            id,
        userId:        userId,
        userName:      userName,
        userPhotoUrl:  userPhotoUrl,
        groupId:       groupId,
        groupName:     groupName,
        imageUrl:      imageUrl,
        caption:       caption,
        audience:      audience,
        likesCount:    likesCount ?? this.likesCount,
        commentsCount: commentsCount ?? this.commentsCount,
        likedByMe:     likedByMe ?? this.likedByMe,
        isOwn:         isOwn,
        createdAt:     createdAt,
      );
}
