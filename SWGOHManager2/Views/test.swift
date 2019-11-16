//
//  test.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 09.11.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

class UserInput: ObservableObject {
    @Published var score: Int = 0
}

struct test: View {
    @ObservedObject var input = UserInput() //please, note the difference between this...
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World\(self.input.score)")
                Button(action: {self.input.score += 1})
                    {
                        Text("Adder")
                    }
                NavigationLink(destination: secondScreen(input: self.input)) {
                    Text("Next View")
                }

            }
        }

    }
}

struct secondScreen: View {
    @ObservedObject var input: UserInput //... and this!
    var body: some View {
        VStack {
            Text("Button has been pushed \(input.score)")
            Button(action: {self.input.score += 1
            }) {
                Text("Adder")
            }
        }

    }
}

#if DEBUG
struct test_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
