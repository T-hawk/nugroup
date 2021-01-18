//
//  SettingsView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/16/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userData: UserData
    var body: some View {
        Form {
            Button("Logout") {
                userData.logout()
                withAnimation(.easeIn(duration: 0.5)) {
                    router.currentPage = .login
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
