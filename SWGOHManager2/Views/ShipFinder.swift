//
//  ShipFinder.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 17.11.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

struct ShipFinder: View {
    @ObservedObject var shipsNetworkManager: ShipsNetworkManager = ShipsNetworkManager()
       
    @State private var searchTerm: String = ""
    @State private var showingModal: Bool = false
    @State var shipFinder: Bool = false
           var body: some View {
               NavigationView{
                List{
                    SearchBar(text: $searchTerm)
                    ForEach(shipsNetworkManager.ships.filter{
                        self.searchTerm.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                        }, id: \.self){ ship in
                            NavigationLink(destination: StarsAndGuildSelector(character: "", ship: ship.name)){
                       ShipsView(ship: ship)
                            }
               }.navigationBarTitle(Text("Ships"))
               }
            }
            
    }
       
       struct ShipsView: View {
           var ship: Ship
           var body: some View{
                   VStack{
                       imageView(url: "https://swgoh.gg" + ship.image)
                       Text(ship.name)
//                           Text("Find " + ship.name)
                       }
                   }

           }
}

struct ShipFinder_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}
