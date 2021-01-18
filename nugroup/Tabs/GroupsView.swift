//
//  GroupsView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/16/21.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var userData: UserData
    @State var groups: [UserGroupsQuery.Data.User.Group] = []
    @State var groupForm = false
    var body: some View {
        NavigationView {
            List {
                ForEach(groups, id: \.id) { group in
                    NavigationLink(destination: GroupView(groupId: group.id, groupName: group.name).environmentObject(userData)) {
                        Text(group.name)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Groups").font(.title)
                        Button(action: {
                            groupForm.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }.onAppear {
            Network.shared.apollo.fetch(query: UserGroupsQuery(userId: userData.id, authToken: userData.authToken)) { result in
                switch result {
                case .success(let graphQLResult):
                    groups = graphQLResult.data!.user.groups ?? []
                case .failure(_): break
                }
            }
        }.sheet(isPresented: $groupForm) {
            GroupFormView(onComplete: { group in
                groupForm.toggle()
                if group != nil {
                    groups.append(group!)
                }
            }).environmentObject(userData)
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
