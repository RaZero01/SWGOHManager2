//
//  Finder.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 17.11.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

struct CharacterFinder: View {
    @ObservedObject var charactersNetworkManager: CharactersNetworkManager = CharactersNetworkManager()
       
    @State private var searchTerm: String = ""
    @State private var showingModal: Bool = false
    @State var characterFinder: Bool = false
           var body: some View {
               NavigationView{
                List{
                    SearchBar(text: $searchTerm)
                    ForEach(charactersNetworkManager.characters.filter{
                        self.searchTerm.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                        }, id: \.self){ character in
                            NavigationLink(destination: StarsAndGuildSelector(character: character.name, ship: "")){
                       HStack{
                                              imageView(url: "https://swgoh.gg" + character.image)
                                              Text(character.name)
                       //                           Text("Find " + character.name)
                                              }
                            }
               }.navigationBarTitle(Text("Characters"))
               }
            }
            
    }
}

struct CharacterFinder_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFinder()
    }
}
