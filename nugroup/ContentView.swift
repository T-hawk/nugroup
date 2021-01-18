//
//  ContentView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/15/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userData: UserData
    var body: some View {
        TabView {
            GroupsView().tabItem {
                Text("Groups")
                Image(systemName: "person.2")
            }.environmentObject(userData)
            SettingsView().tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }.environmentObject(router).environmentObject(userData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
