//
//  GroupView.swift
//  nugroup
//
//  Created by Thomas Grinstead on 1/17/21.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var userData: UserData
    @State var groupId: String
    @State var groupName: String
    @State var group: GroupQuery.Data.Group?
    @State var eventForm = false
    @State var events: [GroupQuery.Data.Group.Event] = []
    var body: some View {
        VStack {
            Text(groupName).font(.title).fontWeight(.bold)
            Divider()
            HStack {
                Text("Events").font(.title3)
                Spacer()
                Button(action: {
                    eventForm.toggle()
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }.padding()
            Divider()
            ScrollView {
                ForEach(events, id: \.id) { event in
                    EventView(event: event).environmentObject(userData)
                }
            }
        }.onAppear {
            Network.shared.apollo.fetch(query: GroupQuery(groupId: groupId, userId: userData.id, authToken: userData.authToken)) { result in
                switch result {
                case .success(let graphQLResult):
                    events = graphQLResult.data?.group.events ?? []
                case .failure(_): break
                }
            }
        }.sheet(isPresented: $eventForm) {
            EventFormView(groupId: groupId, onComplete: { event in
                events.append(event)
                eventForm.toggle()
            }).environmentObject(userData)
        }
    }
}

struct EventView: View {
    @EnvironmentObject var userData: UserData
    @State var event: GroupQuery.Data.Group.Event
    var body: some View {
        NavigationLink(destination: EventDetailsView(eventId: event.id, eventTitle: event.title, eventContent: event.content).environmentObject(userData)) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 5.0)
                VStack {
                    Text(event.title).font(.title3).foregroundColor(.black)
                    Divider()
                    Text(event.content).multilineTextAlignment(.leading).font(.caption).foregroundColor(.black)
                }.padding()
            }.padding().fixedSize(horizontal: false, vertical: true)
        }
    }
}
//
//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}
