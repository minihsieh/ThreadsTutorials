//
//  CreateThreadViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Firebase
import PhotosUI
import SwiftUI

class CreateThreadViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage() }}
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedImage else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }

    
    func uploadThresd(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let image = self.uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image) else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), like: 0, postImageUrl: imageUrl)
        try await ThreadService.uploadThread(thread)
        
    }
}


