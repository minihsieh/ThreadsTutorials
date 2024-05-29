//
//  LoginViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/16.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
    }
}
