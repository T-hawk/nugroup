//
//  LoginView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @State var username = ""
    @State var password = ""
    @State var signUp = false
    var body: some View {
        VStack {
            Text("Login").font(.title)
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Confirm", action: {
                print("confirm")
            })
            Divider()
            Button("Don't have an account?", action: {
                signUp.toggle()
            })
        }.padding().sheet(isPresented: $signUp) { SignUpView() }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
