import Foundation

enum SocialMediaEndpoint: Endpoint {
    // MARK: - Feed
    case getFeed

    // MARK: - Comments
    case publishComment(postId: Int, content: String)
    case deleteComment(commentId: Int)
    case getComments(postId: Int, page: Int)

    // MARK: - Communities
    case createCommunity(name: String, description: String, photo: Data?, banner: Data?)
    case deleteCommunity(communityId: Int)
    case searchCommunities(query: String)
    case getCommunityById(communityId: Int)
    case getUserCommunities(nickname: String)

    // MARK: - Members
    case getMembers(communityId: Int, page: Int)
    case joinCommunity(communityId: Int)
    case leaveCommunity(communityId: Int)

    // MARK: - Friends & Followers
    case followUser(nickname: String)
    case unfollowUser(nickname: String)
    case getFollowers(userId: Int, page: Int)
    case getFollowing(userId: Int, page: Int)
    case getFriends

    // MARK: - Likes
    case likePost(postId: Int)
    case unlikePost(postId: Int)
    case getUsersLikedPost(postId: Int, page: Int)

    // MARK: - Posts
    case publishPost(content: String, postedIn: Int?, imageData: Data?)
    case deletePost(postId: Int)
    case getPostById(postId: Int)
    case getPostsByUser(userId: Int, page: Int)
    case getPostsByNickname(nickname: String, page: Int)


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
        case .getUserCommunities: return "/api/social_media/communities/v1/user"

        // Members
        case .getMembers(let id, _): return "/api/social_media/communities/v1/members/\(id)"
        case .joinCommunity: return "/api/social_media/communities/v1/join"
        case .leaveCommunity: return "/api/social_media/communities/v1/leave"

        // Friends & Followers
        case .followUser: return "/api/social_media/followers/v1/follow"
        case .unfollowUser: return "/api/social_media/followers/v1/unfollow"
        case .getFollowers(let userId, _): return "/api/social_media/followers/v1/\(userId)"
        case .getFollowing(let userId, _): return "/api/social_media/following/v1/\(userId)"
        case .getFriends: return "/api/social_media/friends/v1/list"

        // Likes
        case .likePost: return "/api/social_media/likes/v1/like"
        case .unlikePost: return "/api/social_media/likes/v1/unlike"
        case .getUsersLikedPost(let postId, _): return "/api/social_media/likes/v1/\(postId)"

        // Posts
        case .publishPost: return "/api/social_media/posts/v1/publish"
        case .deletePost: return "/api/social_media/posts/v1/delete"
        case .getPostById: return "/api/social_media/posts/v1/post"
        case .getPostsByUser(let userId, _): return "/api/social_media/posts/v1/user/\(userId)"
        case .getPostsByNickname: return "/api/social_media/posts/v1/user"
        }
    }

    var method: String {
        switch self {
        case .getFeed, .getComments, .searchCommunities, .getCommunityById, .getMembers,
             .getFollowers, .getFollowing, .getUsersLikedPost, .getPostById, .getPostsByUser,
             .getUserCommunities, .getFriends, .getPostsByNickname:
            return "GET"
        case .publishComment, .createCommunity, .joinCommunity, .followUser, .likePost, .publishPost:
            return "POST"
        case .unfollowUser, .deletePost, .unlikePost, .leaveCommunity, .deleteCommunity, .deleteComment:
            return "DELETE"
        }
    }

    var headers: [String: String]? {
        var headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(TokenStore.shared.getJwtToken().token ?? "")"
        ]
        if case .publishPost(_, _, let imageData) = self, imageData != nil {
            headers["Content-Type"] = "application/json"
        }
        if case .createCommunity(_, _, let photo, let banner) = self, photo != nil || banner != nil {
            headers["Content-Type"] = "application/json"
        }
        if case .followUser = self {
            headers["Content-Type"] = "application/json"
        }
        if case .likePost = self {
            headers["Content-Type"] = "application/json"
        }
        if case .joinCommunity = self {
            headers["Content-Type"] = "application/json"
        }
        if case .publishComment = self {
            headers["Content-Type"] = "application/json"
        }
        return headers
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .publishPost(let content, let postedIn, _):
            var items = [URLQueryItem(name: "content", value: content)]
            if let postedIn = postedIn {
                items.append(URLQueryItem(name: "postedIn", value: "\(postedIn)"))
            }
            return items
        case .createCommunity(let name, let description, _, _):
            return [
                URLQueryItem(name: "name", value: name),
                URLQueryItem(name: "description", value: description)
            ]
        case .deleteComment(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .deleteCommunity(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .searchCommunities(let query): return [URLQueryItem(name: "queryContent", value: query)]
        case .getCommunityById(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getUserCommunities(let nickname): return [URLQueryItem(name: "nickname", value: nickname)]
        case .getComments(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getMembers(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .leaveCommunity(let id): return [URLQueryItem(name: "communityId", value: "\(id)")]
        case .unfollowUser(let nickname): return [URLQueryItem(name: "nickname", value: nickname)]
        case .unlikePost(let id): return [URLQueryItem(name: "postId", value: "\(id)")]
        case .getFollowers(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getFollowing(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getUsersLikedPost(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .deletePost(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getPostById(let id): return [URLQueryItem(name: "id", value: "\(id)")]
        case .getPostsByUser(_, let page): return [URLQueryItem(name: "page", value: "\(page)")]
        case .getPostsByNickname(let nickname, let page):
            return [
                URLQueryItem(name: "nickname", value: nickname),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .publishPost(_, _, let imageData):
            guard let imageData = imageData else { return nil }
            let base64Image = imageData.base64EncodedString()
            return try? JSONSerialization.data(withJSONObject: ["image": base64Image])
            
        case .createCommunity(_, _, let photo, let banner):
            var bodyDict: [String: String] = [:]
            if let photoData = photo {
                bodyDict["photo"] = photoData.base64EncodedString()
            }
            if let bannerData = banner {
                bodyDict["banner"] = bannerData.base64EncodedString()
            }
            return try? JSONSerialization.data(withJSONObject: bodyDict)

        case .publishComment(let postId, let content):
            return try? JSONSerialization.data(withJSONObject: ["postId": postId, "content": content])

        case .joinCommunity(let id):
            return try? JSONSerialization.data(withJSONObject: ["communityId": id])

        case .followUser(let nickname):
            return try? JSONSerialization.data(withJSONObject: ["nickname": nickname])

        case .likePost(let id):
            return try? JSONSerialization.data(withJSONObject: ["postId": id])

        default:
            return nil
        }
    }
}

