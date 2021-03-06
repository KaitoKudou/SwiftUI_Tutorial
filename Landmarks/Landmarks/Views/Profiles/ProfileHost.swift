//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 工藤海斗 on 2021/03/02.
//

import SwiftUI

struct ProfileHost: View {
    @State private var draftProfile = Profile.default
    @EnvironmentObject var modelData: ModelData
    @Environment(\.editMode) var editMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel") {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive { // 編集不可の時
                ProfileSummary(profile: modelData.profile)
            } else { // 編集可能の時
                ProfileEditor(profile: $draftProfile)
                    .onAppear(perform: {
                        draftProfile = modelData.profile
                    })
                    .onDisappear(perform: {
                        modelData.profile = draftProfile
                    })
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}
