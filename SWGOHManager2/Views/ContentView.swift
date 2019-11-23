//
//  ContentView.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 18.09.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI
//import Alamofire
import Combine



struct ContentView: View {

    @State var showCharacters = false
    @State var showShips = false
    @State var chooseGuild = false
    @State var characterFinder = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                self.showCharacters.toggle()
            }) {
            Text("Characters Info")
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .cornerRadius(8)
            }.sheet(isPresented: $showCharacters){
                CharacterView()
            }
            Button(action: {
                self.showShips.toggle()
            }) {
                Text("Ships Info")
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .cornerRadius(8)
            }.sheet(isPresented: $showShips){
                ShipView()
            }
            Button(action: {
                self.chooseGuild.toggle()
            }) {
                Text("Select Guild")
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .cornerRadius(8)
            }.sheet(isPresented: $chooseGuild){
                GuildChooser()
            }
            Button(action: {
                self.characterFinder.toggle()
            }) {
                Text("Find Character")
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .cornerRadius(8)
            }.sheet(isPresented: $characterFinder){
                CharacterFinder()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
