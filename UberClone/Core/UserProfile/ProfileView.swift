//
//  ProfileView.swift
//  UberClone
//
//  Created by Kailash Bora on 29/01/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var mapState: MapViewState
    var body: some View {
        VStack {
            /// User image and Name
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("Person Name")
                    Text("4.5 rating")
                }.padding()
                Spacer()
                HomeActionButtonView(mapState: $mapState)
                    .padding(.leading, 50)
            }.padding()

            /// List view for presonal details / Rides / settings
            List {
                ForEach(ProfileViewState.allCases) { type in
                    NavigationLink(destination: {
                        AnyView(EmptyView())
                    }, label: {
                        Text(type.description)
                    })
                }
            }
        }.padding(.top, 70)
    }
}

#Preview {
    ProfileView(mapState: .constant(.noInput))
}
