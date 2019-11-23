//
//  ShipView.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 30.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

struct Ship: Decodable, Hashable {
    let name, image, description, alignment, role: String
}

class ShipsNetworkManager: ObservableObject {
    
    @Published var ships: [Ship] = [Ship]()
    
    func getShips(){
        guard let url = URL(string: "https://swgoh.gg/api/ships/") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let ships = try JSONDecoder().decode([Ship].self, from: data!)
                DispatchQueue.main.async {
                    self.ships = ships
                    print(ships)
                }
            } catch {
                print("Failed to decode: ", error)
            }
            
        }.resume()
        
    }
    init() {
        getShips()
    }
    
}

struct ShipView: View {
    
    @ObservedObject var shipsNetworkManager: ShipsNetworkManager = ShipsNetworkManager()
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView{
            List{
            SearchBar(text: $searchTerm)
                ForEach(shipsNetworkManager.ships.filter{
                    self.searchTerm.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                    }
                , id: \.self){
                ship in
                NavigationLink(destination: DetailShipInfo(ship: ship)){
                    ShipView(ship: ship)
                }
            }.navigationBarTitle(Text("Ships"))
        }
        }
    }
    struct ShipView: View {
    var ship:Ship
    var body: some View{
            VStack{
                imageView(url: "https://swgoh.gg" + ship.image)
                Text(ship.name)
//                    Text("More about " + ship.name)
                }
            }

    }
}



struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}
