//
//  GuildView.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 01.11.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI


struct Guild: Decodable {
    let data: GuildData
    
    struct GuildData: Decodable, Hashable {
        let name: String
        let member_count, id, galactic_power: Int
    }
}

struct Players: Decodable{
    let players: [PlayerData]
    struct PlayerData: Decodable{
        let data: PlayerInfo
        let units: [UnitData]
        struct PlayerInfo: Decodable{
            let name: String
            let ally_code: Int
        }
        struct UnitData: Decodable {
            let data: UnitInfo
            struct UnitInfo: Decodable {
                let name: String
                let rarity: Int
            }
        }
    }
}

       
struct GuildView: View {
    var guild:Guild
    var players: Players
    var rarity: Int
    var character, ship: String
    @State var isPressed: Bool = false
    
    var body: some View{
        
        let activePlayers = showPlayers(players: players, character: character, ship: ship, rarity: rarity)
        
        return (
        VStack {
            
            Text("Guild: " + guild.data.name)
                .font(.largeTitle)
            Button(action: {
                self.isPressed.toggle()
            }){
                Text("Info")
                    .padding(12)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            if (isPressed){
                VStack(spacing: 20){
                    
                    Text("Galactic Power: " + String(guild.data.galactic_power))
                        .font(.title)
                    Text("Members: " + String(guild.data.member_count))
                        .font(.title)
                    Text("ID: " + String(guild.data.id))
                        .font(.title)
                    Text("Character: " + character)
                        .font(.title)
                    Text("Ship: " + ship)
                        .font(.title)
                    Text("Rarity: " + String(rarity))
                        .font(.title)
                }
                
            }
            
            List{
                ForEach(activePlayers, id:\.self){ player in
                Text(player)
                }
            }

        }
        )
    }
}

func showPlayers(players: Players, character: String, ship: String, rarity: Int) -> [String]{
    var mass = [String]()
    
    for player in players.players{
        for unit in player.units{
            if ((unit.data.rarity == rarity) && ((unit.data.name == character) || (unit.data.name == ship))){
                mass.append(player.data.name)
            }
        }
    }
//    print(mass)
    return mass
}
