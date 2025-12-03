import Foundation

final class SocialMediaAPIClient {
    private let client = APIClient()

    // MARK: - Feed
    func getFeed() async throws -> FeedResponse {
        try await client.request(SocialMediaEndpoint.getFeed)
    }

    // MARK: - Comments
    func publishComment(postId: Int, content: String) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.publishComment(postId: postId, content: content))
    }

    func deleteComment(id: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.deleteComment(commentId: id))
    }

    func getComments(postId: Int, page: Int) async throws -> [Comment] {
        try await client.request(SocialMediaEndpoint.getComments(postId: postId, page: page))
    }

    // MARK: - Communities
    func createCommunity(name: String, description: String, photo: Data?, banner: Data?) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.createCommunity(name: name, description: description, photo: photo, banner: banner))
    }

    func deleteCommunity(communityId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.deleteCommunity(communityId: communityId))
    }

    func searchCommunities(query: String) async throws -> [Community] {
        try await client.request(SocialMediaEndpoint.searchCommunities(query: query))
    }

    func getCommunityById(communityId: Int) async throws -> Community {
        try await client.request(SocialMediaEndpoint.getCommunityById(communityId: communityId))
    }
    
    func getUserCommunities(nickname: String) async throws -> [Int] {
        let result: GetUserCommunitiesQueryResult = try await client.request(SocialMediaEndpoint.getUserCommunities(nickname: nickname))
        return result.communityIds
    }

    // MARK: - Members
    func getMembers(communityId: Int, page: Int) async throws -> [Member] {
        try await client.request(SocialMediaEndpoint.getMembers(communityId: communityId, page: page))
    }

    func joinCommunity(communityId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.joinCommunity(communityId: communityId))
    }

    func leaveCommunity(communityId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.leaveCommunity(communityId: communityId))
    }

    // MARK: - Friends & Followers
    func followUser(nickname: String) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.followUser(nickname: nickname))
    }

    func unfollowUser(nickname: String) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.unfollowUser(nickname: nickname))
    }

    func getFollowers(userId: Int, page: Int) async throws -> [Follower] {
        try await client.request(SocialMediaEndpoint.getFollowers(userId: userId, page: page))
    }

    func getFollowing(userId: Int, page: Int) async throws -> [Follower] {
        try await client.request(SocialMediaEndpoint.getFollowing(userId: userId, page: page))
    }
    
    func getFriends() async throws -> [String] {
        let result: GetFriendsQueryResult = try await client.request(SocialMediaEndpoint.getFriends)
        return result.friends
    }

    // MARK: - Likes
    func likePost(postId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.likePost(postId: postId))
    }

    func unlikePost(postId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.unlikePost(postId: postId))
    }

    func getUsersLikedPost(postId: Int, page: Int) async throws -> [UsersLiked] {
        try await client.request(SocialMediaEndpoint.getUsersLikedPost(postId: postId, page: page))
    }

    // MARK: - Posts
    func publishPost(content: String, postedIn: Int?, imageData: Data?) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.publishPost(content: content, postedIn: postedIn, imageData: imageData))
    }

    func deletePost(postId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.deletePost(postId: postId))
    }

    func getPostById(postId: Int) async throws -> Feed {
        try await client.request(SocialMediaEndpoint.getPostById(postId: postId))
    }

    func getPostsByUser(userId: Int, page: Int) async throws -> [Feed] {
        try await client.request(SocialMediaEndpoint.getPostsByUser(userId: userId, page: page))
    }
    
    func getPostsByNickname(nickname: String, page: Int) async throws -> [Feed] {
        let result: GetPostsByNicknameQueryResult = try await client.request(SocialMediaEndpoint.getPostsByNickname(nickname: nickname, page: page))
        return result.posts
    }
}

