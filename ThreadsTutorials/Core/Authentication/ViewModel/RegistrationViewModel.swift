//
//  RegistrationViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/16.
//

import Foundation
import SwiftUI

@Observable
class RegistrationViewModel {
//class RegistrationViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var fullname = ""
//    @Published var username = ""
     var email = ""
     var password = ""
     var fullname = ""
     var username = ""
    
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullname,
            username: username
        )
    }
}
