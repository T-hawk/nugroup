//
//  UserData.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/16/21.
//

import Foundation

class UserData: ObservableObject {
    @Published var authToken: String {
        didSet {
            UserDefaults.standard.set(self.authToken, forKey: "authToken")
        }
    }
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(self.username, forKey: "username")
        }
    }
    @Published var id: String {
        didSet {
            UserDefaults.standard.set(self.id, forKey: "id")
        }
    }

    init() {
        self.authToken = UserDefaults.standard.string(forKey: "authToken") ?? ""
        self.id = UserDefaults.standard.string(forKey: "id") ?? ""
        self.username = UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    func logout() {
        self.authToken = ""
        self.id = ""
        self.username = ""
    }
}
