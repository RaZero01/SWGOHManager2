//
//  DetailInfo.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 30.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI



struct DetailCharacterInfo: View {
    
    
    let character: Character
    
    var body: some View {
        VStack(spacing: 20){
            Text(character.name)
                .font(.largeTitle)
            imageView(url: "https://swgoh.gg" + character.image)
            Text(character.alignment)
                .font(.title)
            Text(character.role)
                .font(.title)
            Text(character.description)
//                .frame(minHeight: 70)
                .padding()
                .font(.title)
            
        }
    }
}

