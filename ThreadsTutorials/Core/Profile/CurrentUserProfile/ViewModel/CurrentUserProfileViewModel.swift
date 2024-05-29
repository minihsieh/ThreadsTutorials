//
//  ProfileViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Foundation
import Combine
import SwiftUI
import PhotosUI

class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var shouldRefresh = false
        
    private var cancellables = Set<AnyCancellable>()
    
    static let shared = CurrentUserProfileViewModel()
    
    init() {
        setupSubscribers()
    }
        
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellables)
            
    }
    
    
}
