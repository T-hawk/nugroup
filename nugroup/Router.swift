//
//  Router.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import Foundation

class Router: ObservableObject {
    @Published var currentPage: Page
    
    init() {
        let userData = UserData()
        self.currentPage = (userData.authToken == "" || userData.id == "" || userData.username == "") ? .login : .main
    }
}


enum Page {
    case login
    case main
}
