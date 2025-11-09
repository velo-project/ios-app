//
//  SocialMediaAPIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

protocol SocialMediaAPIClient {
    func getFeed() async throws -> [Feed]
    func publishComment(postId: Int, content: String) async throws
    func deleteComment(id: Int) async throws
    func createCommunity(name: String, description: String) async throws
}

final class SocialMediaAPIClientImpl: SocialMediaAPIClient {
    private let client = APIClient()

    // MARK: - Feed
    func getFeed() async throws -> [Feed] {
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
    func createCommunity(name: String, description: String) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.createCommunity(name: name, description: description))
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

    // MARK: - Followers
    func followUser(userId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.followUser(userId: userId))
    }

    func unfollowUser(userId: Int) async throws {
        try await client.requestNoResponse(SocialMediaEndpoint.unfollowUser(userId: userId))
    }

    func getFollowers(userId: Int, page: Int) async throws -> [Follower] {
        try await client.request(SocialMediaEndpoint.getFollowers(userId: userId, page: page))
    }

    func getFollowing(userId: Int, page: Int) async throws -> [Follower] {
        try await client.request(SocialMediaEndpoint.getFollowing(userId: userId, page: page))
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
}

