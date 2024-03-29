//
//  CharacterView.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 30.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

struct Character: Decodable, Hashable {
    let name, image, description, alignment, role: String
}



class CharactersNetworkManager: ObservableObject {
    
    @Published var characters: [Character] = [Character]()
    
    func getCharacters(){
        guard let url = URL(string: "https://swgoh.gg/api/characters/") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data!)
                DispatchQueue.main.async {
                    self.characters = characters
                }
            } catch {
                print("Failed to decode: ", error)
            }
            
        }.resume()
        
    }
    init() {
        getCharacters()
    }
    
}

struct CharacterView: View {
     @ObservedObject var charactersNetworkManager: CharactersNetworkManager = CharactersNetworkManager()
       
    @State private var searchTerm: String = ""
           var body: some View {
               NavigationView{
                List{
                    SearchBar(text: $searchTerm)
                    ForEach(charactersNetworkManager.characters.filter{
                        self.searchTerm.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                        }, id: \.self){ character in

                   NavigationLink(destination: DetailCharacterInfo(character: character)){
                      HStack{
                        imageView(url: "https://swgoh.gg" + character.image)
                        Text(character.name)
                        }
                    }
               }.navigationBarTitle(Text("Characters"))
               }
            }
    }
}

class ImageLoader: ObservableObject {
    @Published var data:Data = Data()
    
    func getImage(image: String){
        guard let url = URL(string: image) else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if let data = data{
                    self.data = data
                }
            }
//            print(data)
        }.resume()
    }
    init(image: String) {
        getImage(image: image)
    }
}

struct imageView: View{
    
    @ObservedObject var imageLoader:ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(image: url)
    }
    
    var body: some View{
        Image(uiImage: UIImage(data: imageLoader.data) ?? UIImage()).resizable().frame(width: 70, height: 70)
    }
    
}


struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
