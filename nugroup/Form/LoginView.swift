//
//  LoginView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userData: UserData
    @State var username = ""
    @State var password = ""
    @State var signUp = false
    var body: some View {
        VStack {
            Text("Login").font(.title)
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Confirm", action: {
                Network.shared.apollo.perform(mutation: LoginMutation(username: username, password: password)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        userData.authToken = (graphQLResult.data?.login?.authToken)!
                        userData.id = (graphQLResult.data?.login?.user?.id)!
                        userData.username = (graphQLResult.data?.login?.user?.username)!
                        withAnimation(.easeIn(duration: 0.5)) {
                            router.currentPage = .main
                        }
                    case .failure(let error): break
                    }
                }
            })
            Divider()
            Button("Don't have an account?", action: {
                signUp.toggle()
            })
        }.padding().sheet(isPresented: $signUp) { SignUpView().environmentObject(router) }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
