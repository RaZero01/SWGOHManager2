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
    @State var isPressed: Bool = false
    var body: some View{
        
        VStack {
            Button(action: {
                print("test")
                self.isPressed.toggle()
            }){
                Text("Info")
            }
            if (isPressed){
                VStack(spacing: 20){
                                    Text("Guild: " + guild.data.name)
                                        .font(.largeTitle)
                                    Text("Galactic Power: " + String(guild.data.galactic_power))
                                        .font(.title)
                                    Text("Members: " + String(guild.data.member_count))
                                        .font(.title)
                                    Text("ID: " + String(guild.data.id))
                                        .font(.title)
                //                Text(players.players[0].data.name)
                                
                            }
            }
            List(players.players, id:\.data.name){ player in
                HStack {
                    Text(player.data.name)
                    List(player.units, id:\.data.name){ unit in
                            
//                            Text(unit.data.name + ": " + String(unit.data.rarity))
                        if (unit.data.rarity == 7){
                            Text(unit.data.name)
                        } else {
                            Text("No data")
                        }
                    }
                }
            }
        }
    }
}
