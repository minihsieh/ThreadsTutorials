//
//  RegistrationView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/14.
//

import SwiftUI

struct RegistrationView: View {
    @State var viewModel = RegistrationViewModel()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image(.threadsAppIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                
                .padding()
            VStack {
                TextField("Enter your email",text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
                SecureField("Enter your Password", text: $viewModel.password)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your full name",text: $viewModel.fullname)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your username",text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
            }
            
            Button(action: {
                Task{
                    try await viewModel.createUser()
                }
            }, label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }).padding(.top, 20)
            
            Spacer()
            
            Divider()
            
            Button(action: {
                dismiss()
            }, label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundColor(.black)
            })
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
