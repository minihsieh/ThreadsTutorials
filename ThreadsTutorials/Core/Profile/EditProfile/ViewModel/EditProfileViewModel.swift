//
//  EditProfileViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import PhotosUI
import SwiftUI


class EditProfileViewModel: ObservableObject{
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage() }}
    }
    
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    @MainActor
    func updateUserData() async throws {
        try await updateProfileImage()
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedImage else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
}
