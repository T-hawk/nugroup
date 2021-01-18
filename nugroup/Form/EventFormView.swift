//
//  SwiftUIView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/17/21.
//

import SwiftUI

struct EventFormView: View {
    @EnvironmentObject var userData: UserData
    @State var title = ""
    @State var content = ""
    @State var groupId: String
    let onComplete: (GroupQuery.Data.Group.Event) -> Void
    var body: some View {
        VStack {
            Text("New Event").font(.title)
            TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Content", text: $content).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Confirm", action: {
                Network.shared.apollo.perform(mutation: CreateEventMutation(title: title, content: content, groupId: groupId, userId: userData.id, authToken: userData.authToken)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        let event = graphQLResult.data?.createEvent?.event!
                        onComplete(GroupQuery.Data.Group.Event(id: event!.id, title: event!.title, content: event!.content))
                    case .failure(_): break
                    }
                }
            })
        }.padding()
    }
}
