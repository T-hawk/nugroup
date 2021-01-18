//
//  GroupFormView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/17/21.
//

import SwiftUI

struct GroupFormView: View {
    @EnvironmentObject var userData: UserData
    @State var name = ""
    let onComplete: (UserGroupsQuery.Data.User.Group?) -> Void
    var body: some View {
        VStack {
            Text("Nu Group")
            TextField("Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Confirm", action: {
                Network.shared.apollo.perform(mutation: CreateGroupMutation(name: name, userId: userData.id, authToken: userData.authToken)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        onComplete(UserGroupsQuery.Data.User.Group(id: (graphQLResult.data?.createGroup?.group!.id)!, name: (graphQLResult.data?.createGroup?.group!.name)!))
                    case .failure(_): break
                    }
                }
            })
        }.padding()
    }
}
//
//struct GroupFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupFormView()
//    }
//}
