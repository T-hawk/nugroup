//
//  SignUpView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var router: Router
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
                print("confirm")
            })
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
