//
//  nugroupApp.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

@main
struct nugroupApp: App {
    @StateObject var router = Router()
    @StateObject var userData = UserData()
    var body: some Scene {
        WindowGroup {
            switch router.currentPage {
            case .login:
                LoginView().environmentObject(router).environmentObject(userData)
            case .main:
                ContentView().environmentObject(router).environmentObject(userData)
            }
        }
    }
}
