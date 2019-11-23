//
//  GuildChooser.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 06.11.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI



func getGuild(id: String, completion: @escaping (_ guild: Guild?, _ player: Players?) -> ()){
    var guildData: Guild?
    var players: Players?
    guard let url = URL(string: "https://swgoh.gg/api/guild/" + id + "/") else {return}
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        do {
            let currentGuild = try JSONDecoder().decode(Guild.self, from: data!)
            let playersArray = try JSONDecoder().decode(Players.self, from: data!)
//            let testData = try JSONSerialization.jsonObject(with: data!)
//            print(testData)
            players = playersArray
            guildData = currentGuild
            completion(guildData, players)
        } catch {
            print("Failed to decode: ", error)
        }
    }.resume()
}

struct GuildChooser: View {
    @State var GuildID = ""
    @State var showGuild = false
    @State var guildData: Guild?
    @State var playersData: Players?
//    @State var playersData: [PlayerData]
    
    @State var spin3D_x = false
    @State var spin3D_y = false
    @State var spin3D_xy = false
    
    var body: some View {
        
        VStack {
            TextField("Guild ID", text: $GuildID)
                .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 2)
            )
            .padding()
            Button(action: {
                print(self.GuildID)
                self.guildData = nil
                getGuild(id: self.GuildID) { (guild, players) in
                    self.guildData = guild
                    self.playersData = players
                    print(self.guildData!)
//                    for player in self.playersData!.players{
//                        print(player.data.name + "//------------")
//                        for unit in player.units{
//                            print(unit.data.name + ": " + String(unit.data.rarity))
//                            
//                        }
//                    }
                }
                self.showGuild.toggle()
                
            }) {
                Text("Select Guild")
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .cornerRadius(8)
            }.sheet(isPresented: $showGuild){
                
                if (self.guildData != nil){
                    GuildView(guild: self.guildData!, players: self.playersData!, rarity: 0, character: "", ship: "")
                } else{
                    ZStack{
                        RadialGradient(gradient: Gradient(colors: [Color.white, Color.blue]), center: .center, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
                            .scaleEffect(2)
                            //.opacity(0.80)
                        Circle() // Large circle
                            .stroke(lineWidth: 5)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .rotation3DEffect(.degrees(self.spin3D_x ? 180 : 1), axis: (x: self.spin3D_x ? 1 : 0, y: 0, z: 0))
                            .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: true))
                            .onAppear(){
                                self.spin3D_x.toggle()
                            }
                        Circle() // Middle circle
                            .stroke(lineWidth: 5)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                            .rotation3DEffect(.degrees(self.spin3D_y ? 360 : 1), axis: (x: 0, y: self.spin3D_y ? 1 : 0, z: 0))
                            .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false))
                            .onAppear(){
                                self.spin3D_y.toggle()
                            }
                        Circle() // Inner Circle
                            .stroke(lineWidth: 5)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                            .rotation3DEffect(.degrees(self.spin3D_xy ? 180 : 1), axis: (x: self.spin3D_xy ? 0 : 1, y: self.spin3D_xy ? 0 : 1, z: 0))
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                            .onAppear(){
                                self.spin3D_xy.toggle()
                            }
                    }
                }
            }

        }
        
    }
}

struct GuildChooser_Previews: PreviewProvider {
    static var previews: some View {
        GuildChooser()
    }
}
