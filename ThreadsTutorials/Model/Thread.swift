//
//  Thread.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var like: Int
    var replyCount: Int?
    var forwardCount: Int?
    var postImageUrl: String?
    var isReply: Bool = false
    
    var id:String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
    var didLike: Bool?
    
    static var mockThread: Thread {
//        return Thread(ownerUid: "123", caption: "This is test thread", timestamp: Timestamp(), like: 0, postImageUrl: "https://s.yimg.com/ny/api/res/1.2/OSJ7tzRVjF60vy0eJkDUSA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTU0MDtjZj13ZWJw/https://media.zenfs.com/zh-tw/news_tvbs_com_tw_938/000fbc5f284ff62fd07d765cee2b9477")
        return Thread(ownerUid: "123", caption: "This is test thread", timestamp: Timestamp(), like: 0)
    }
}
