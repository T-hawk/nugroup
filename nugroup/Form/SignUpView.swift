//
//  SignUpView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userData: UserData
    @State var username = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var signUp = false
    var body: some View {
        VStack {
            Text("Sign Up").font(.title)
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password Confirmation", text: $passwordConfirmation).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Confirm", action: {
                Network.shared.apollo.perform(mutation: CreateUserMutation(username: username, password: password, passwordConfirmation: passwordConfirmation)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        userData.authToken = (graphQLResult.data?.createUser?.authToken)!
                        userData.id = (graphQLResult.data?.createUser?.user?.id)!
                        userData.username = (graphQLResult.data?.createUser?.user?.username)!
                        withAnimation(.easeIn(duration: 0.5)) {
                            router.currentPage = .main
                        }
                    case .failure(let error): break
                    }
                }
            })
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
