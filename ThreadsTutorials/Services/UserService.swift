//
//  UserService.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
//    @MainActor
//    func fetchCurrentUser() async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//        let user = try snapshot.data(as: User.self)
//        self.currentUser = user
//
//    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        let snapshot = try await fetchCurrentUserDocument()
        self.currentUser = try snapshot.data(as: User.self)
    }
    
//    func fetchUsers() async throws -> [User] {
//        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
//        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
//        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self)})
//        return users.filter({ $0.id != currentUid})
//    }
    
    /* Extract Variable
        fetchUsers() 中,使用查詢表達式替代了臨時變數,因此沒有提取變量的必要。
     */
    func fetchUsers() async throws -> [User] {
        let documents = try await fetchUsersDocuments()
        // Replace Temp with Query -> 在 fetchUsers() 中,使用查詢表達式 compactMap 替代了創建 User 實例的臨時變數。
        return try documents.compactMap { try $0.data(as: User.self) }
    }
    
    func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func reset() {
        self.currentUser = nil
    }
    
//    @MainActor
//    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//        // 將profile Image Url upadate至firebase user裡
//        try await Firestore.firestore().collection("users").document(currentUid).updateData([
//            "profileImageUrl" : imageUrl
//        ])
//        self.currentUser?.profileImageUrl = imageUrl
//    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        try await updateUserProfileImageInFirestore(withImageUrl: imageUrl)
        self.currentUser?.profileImageUrl = imageUrl
    }
    
    // MARK: - Private Methods (Extract Method)
        
        @MainActor
        private func fetchCurrentUserDocument() async throws -> DocumentSnapshot {
            guard let uid = Auth.auth().currentUser?.uid else {
                throw UserServiceError.userNotAuthenticated
            }
            return try await Firestore.firestore().collection("users").document(uid).getDocument()
        }
        
        private func fetchUsersDocuments() async throws -> [QueryDocumentSnapshot] {
            guard let currentUid = Auth.auth().currentUser?.uid else {
                throw UserServiceError.userNotAuthenticated
            }
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            return snapshot.documents.filter { $0.documentID != currentUid }
        }
        
        @MainActor
        private func updateUserProfileImageInFirestore(withImageUrl imageUrl: String) async throws {
            guard let currentUid = Auth.auth().currentUser?.uid else {
                throw UserServiceError.userNotAuthenticated
            }
            try await Firestore.firestore().collection("users").document(currentUid).updateData([
                "profileImageUrl": imageUrl
            ])
        }
}

enum UserServiceError: Error {
    case userNotAuthenticated
}
