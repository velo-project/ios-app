import Foundation

enum SocialMediaEndpoint: Endpoint {
    // MARK: - Feed
    case getFeed

    // MARK: - Comments
    case publishComment(postId: Int, content: String)
    case deleteComment(commentId: Int)
    case getComments(postId: Int, page: Int)

    // MARK: - Communities
    case createCommunity(name: String, description: String)
    case deleteCommunity(communityId: Int)
    case searchCommunities(query: String)
    case getCommunityById(communityId: Int)

    // MARK: - Members
    case getMembers(communityId: Int, page: Int)
    case joinCommunity(communityId: Int)
    case leaveCommunity(communityId: Int)

    // MARK: - Followers
    case followUser(userId: Int)
    case unfollowUser(userId: Int)
    case getFollowers(userId: Int, page: Int)
    case getFollowing(userId: Int, page: Int)

    // MARK: - Likes
    case likePost(postId: Int)
    case unlikePost(postId: Int)
    case getUsersLikedPost(postId: Int, page: Int)

    // MARK: - Posts
    case publishPost(content: String, postedIn: Int?, imageData: Data?)
    case deletePost(postId: Int)
    case getPostById(postId: Int)
    case getPostsByUser(userId: Int, page: Int)

    // MARK: - Base

    var path: String {
        switch self {
        case .getFeed:
            return "/api/social_media/feeds/v1/feed"

        // Comments
        case .publishComment: return "/api/social_media/comments/v1/publish"
        case .deleteComment: return "/api/social_media/comments/v1/delete"
        case .getComments(let postId, _): return "/api/social_media/comments/v1/\(postId)"

        // Communities
        case .createCommunity: return "/api/social_media/communities/v1/create"
        case .deleteCommunity: return "/api/social_media/communities/v1/delete"
        case .searchCommunities: return "/api/social_media/communities/v1/search"
        case .getCommunityById: return "/api/social_media/communities/v1/community"

        // Members
        case .getMembers(let id, _): return "/api/social_media/communities/v1/members/\(id)"
        case .joinCommunity: return "/api/social_media/communities/v1/join"
        case .leaveCommunity: return "/api/social_media/communities/v1/leave"

        // Followers
        case .followUser: return "/api/social_media/followers/v1/follow"
        case .unfollowUser: return "/api/social_media/followers/v1/unfollow"
        case .getFollowers(let userId, _): return "/api/social_media/followers/v1/\(userId)"
        case .getFollowing(let userId, _): return "/api/social_media/following/v1/\(userId)"

        // Likes
        case .likePost: return "/api/social_media/likes/v1/like"
        case .unlikePost: return "/api/social_media/likes/v1/unlike"
        case .getUsersLikedPost(let postId, _): return "/api/social_media/likes/v1/\(postId)"

        // Posts
        case .publishPost: return "/api/social_media/posts/v1/publish"
        case .deletePost: return "/api/social_media/posts/v1/delete"
        case .getPostById: return "/api/social_media/posts/v1/post"
        case .getPostsByUser(let userId, _): return "/api/social_media/posts/v1/user/\(userId)"
        }
    }

    var method: String {
        switch self {
        case .getFeed, .getComments, .searchCommunities, .getCommunityById, .getMembers,
             .getFollowers, .getFollowing, .getUsersLikedPost, .getPostById, .getPostsByUser:
            return "GET"
        case .publishComment, .createCommunity, .joinCommunity, .followUser, .likePost, .publishPost:
            return "POST"
        default:
            return "DELETE"
        }
    }

    var headers: [String: String]? {
        let token = TokenStore().getJwtToken().token ?? ""
        return [
            "Accept": "application/json",
            "Authorization": token
        ]
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .deleteComment(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .deleteCommunity(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .searchCommunities(let query): return [URLQueryItem(name: "queryContent", value: query)]
        case .getCommunityById(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getComments(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getMembers(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .leaveCommunity(let id): return [URLQueryItem(name: "communityId", value: "\(id)")]
        case .unfollowUser(let id): return [URLQueryItem(name: "userId", value: "\(id)")]
        case .unlikePost(let id): return [URLQueryItem(name: "postId", value: "\(id)")]
        case .getFollowers(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getFollowing(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getUsersLikedPost(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .deletePost(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getPostById(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getPostsByUser(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .publishComment(let postId, let content):
            return try? JSONSerialization.data(withJSONObject: ["postId": postId, "content": content])
        case .createCommunity(let name, let description):
            return try? JSONSerialization.data(withJSONObject: ["name": name, "description": description])
        case .joinCommunity(let id):
            return try? JSONSerialization.data(withJSONObject: ["communityId": id])
        case .followUser(let id):
            return try? JSONSerialization.data(withJSONObject: ["userId": id])
        case .likePost(let id):
            return try? JSONSerialization.data(withJSONObject: ["postId": id])
        case .publishPost(let content, let postedIn, _):
            var json: [String: Any] = ["content": content]
            if let postedIn { json["postedIn"] = postedIn }
            return try? JSONSerialization.data(withJSONObject: json)
        default:
            return nil
        }
    }
}
