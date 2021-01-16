//
//  Router.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import Foundation

class Router: ObservableObject {
    @Published var currentPage: Page = .login
}

enum Page {
    case login
    case main
}
