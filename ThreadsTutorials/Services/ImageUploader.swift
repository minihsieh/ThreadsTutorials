//
//  ImageUploader.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.25) else { return nil }
        let filename = NSUUID().uuidString
        let storeRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await storeRef.putDataAsync(imageData)
            let url = try await storeRef.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Fail to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
