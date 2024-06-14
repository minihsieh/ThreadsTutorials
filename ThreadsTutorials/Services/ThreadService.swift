//
//  ThreadService.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
//    static func fetchThread() async throws -> [Thread] {
//        let snapshot = try await Firestore.firestore().collection("threads").order(by: "timestamp", descending: true).getDocuments()
//        return snapshot.documents.compactMap ({
//            try? $0.data(as: Thread.self)
//        })
//    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await fetchThreadDocuments()
        return try decodeThreads(from: snapshot)
    }
    
//    static func fetchUserThreads(uid: String) async throws -> [Thread] {
//        let snapshot = try await Firestore
//            .firestore()
//            .collection("threads")
//            .whereField("ownerUid", isEqualTo: uid)
//            .getDocuments()
//        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
//        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
//    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await fetchUserThreadDocuments(uid: uid)
        let threads = try decodeThreads(from: snapshot)
        return threads.sorted(by: descendingTimestampComparator)
    }
    
    // MARK: - Private Methods(Extract Method)
        
    private static func fetchThreadDocuments() async throws -> QuerySnapshot {
        return try await Firestore.firestore().collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
    }
    
    private static func fetchUserThreadDocuments(uid: String) async throws -> QuerySnapshot {
        return try await Firestore.firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
    }
    
    private static func decodeThreads(from snapshot: QuerySnapshot) throws -> [Thread] {
        return try snapshot.documents.compactMap { try $0.data(as: Thread.self) }
    }
    
    private static let descendingTimestampComparator: (Thread, Thread) -> Bool = { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    
}

extension ThreadService {
    
    func likeThread(_ thread: Thread, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userLikesRef = Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
        
        Firestore.firestore().collection("threads").document(thread.id)
            .updateData(["like": thread.like + 1]) { _ in
                userLikesRef.document(thread.id).setData([:]) { _ in
                    completion()
                }
            }
    }
    
//    func likeThread(_ thread: Thread) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        let userLikesRef = Firestore.firestore().collection("users")
//            .document(uid).collection("user-likes")
//
//        try await Firestore.firestore().collection("threads").document(thread.id)
//            .updateData(["like": thread.like + 1])
//        try await userLikesRef.document(thread.id).setData([:])
//    }
    
    func unlikeThread(_ thread: Thread, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard thread.like > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
        
        Firestore.firestore().collection("threads").document(thread.id)
            .updateData(["like": thread.like - 1]) { _ in
                userLikesRef.document(thread.id).delete { _ in
                    completion()
                }
            }
    }
    
//    func unlikeThread(_ thread: Thread) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard thread.like > 0 else { return }
//
//        let userLikesRef = Firestore.firestore().collection("users")
//            .document(uid).collection("user-likes")
//
//        try await Firestore.firestore().collection("threads").document(thread.id)
//            .updateData(["like": thread.like - 1])
//        try await userLikesRef.document(thread.id).delete()
//    }
    
    func checkIfLikeThread(_ thread: Thread, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
            .document(thread.id).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
                
            }
    }
    
//    static func fetchLikeThreads(forUid uid: String, completion: @escaping([Thread]) -> Void) {
//        var threads = [Thread]()
//        Firestore.firestore().collection("users")
//            .document(uid).collection("user-likes")
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents else { return }
//
//                documents.forEach { doc in
//                    let threadId = doc.documentID
//                    Firestore.firestore().collection("threads")
//                        .document(threadId)
//                        .getDocument { snapshot, _ in
//                            guard let thread = try? snapshot?.data(as: Thread.self) else { return }
//                            threads.append(thread)
//                            completion(threads)
//                        }
//                }
//            }
//    }
    
    
    static func fetchLikeThreads(forUid uid: String) async throws -> [Thread] {
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments()
        
        var threads = [Thread]()
        
        for doc in snapshot.documents {
            let threadId = doc.documentID
            let threadSnapshot = try await Firestore.firestore().collection("threads")
                .document(threadId).getDocument()
            guard let thread = try? threadSnapshot.data(as: Thread.self) else { continue }
            threads.append(thread)
        }
        return threads
    }
    
    func fetchUpdateThread(_ thread: Thread) async throws -> Thread {
        let snapshot = try await Firestore.firestore().collection("threads").document(thread.id).getDocument()
        return try snapshot.data(as: Thread.self)
    }
    
    func checkUpdateThread(_ thread: Thread, completion: @escaping(Thread) -> Void) {
        Firestore.firestore().collection("threads").document(thread.id)
            .addSnapshotListener { snapshot, error in
            guard let snapshot else { return }
            guard let updateThread = try? snapshot.data(as: Thread.self) else { return }
            completion(updateThread)
        }
    }
}

