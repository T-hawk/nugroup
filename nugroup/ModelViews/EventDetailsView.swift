//
//  EventDetailsView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/17/21.
//

import SwiftUI

struct EventDetailsView: View {
    @EnvironmentObject var userData: UserData
    @State var eventId: String
    @State var eventTitle: String
    @State var eventContent: String
    var body: some View {
        VStack {
            Text(eventTitle).font(.title)
            Text(eventContent).font(.caption)
            Divider()
            Spacer()
            Comments(eventId: eventId).environmentObject(userData)
        }
    }
}

struct Comments: View {
    @EnvironmentObject var userData: UserData
    @State var comments: [EventQuery.Data.Event.Comment] = []
    @State var content = ""
    @State var eventId: String
    var body: some View {
        VStack {
            Text("Comments")
            ScrollView {
                ForEach(comments, id: \.id) { comment in
                    ZStack {
                        RoundedRectangle(cornerRadius: 7).foregroundColor(.white).shadow(radius: 5)
                        HStack {
                            Text(comment.user.username)
                            Divider()
                            Spacer()
                            Text(comment.content)
                        }.padding()
                    }.padding()
                }
            }
            TextField("Comment here...", text: $content).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Button("Confirm", action: {
                Network.shared.apollo.perform(mutation: CreateCommentMutation(content: content, eventId: eventId, userId: userData.id, authToken: userData.authToken)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        let comment = graphQLResult.data?.createComment?.comment
                        let user = EventQuery.Data.Event.Comment.User(id: comment!.user.id, username: comment!.user.username)
                        comments.append(EventQuery.Data.Event.Comment(id: comment!.id, content: comment!.content, user: user))
                    case .failure(_): break
                    }
                }
                content = ""
            }).padding()
        }
        .onAppear {
            Network.shared.apollo.fetch(query: EventQuery(eventId: eventId, userId: userData.id, authToken: userData.authToken)) { result in
                switch result {
                case .success(let graphQLResult):
                    comments = graphQLResult.data?.event.comments ?? []
                case .failure(_): break
                }
            }
        }
    }
}

//struct EventDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailsView()
//    }
//}
