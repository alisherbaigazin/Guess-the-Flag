//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Alisher Baigazin on 02.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "UK", "US", "Spain", "Italy", "Germany", "Ireland", "Poland", "Nigeria", "Russia"].shuffled()
    @State var randomNumber = Int.random(in: 0...2)
    @State var isAlertVisible = false
    @State var message: String = ""
    @State var score: Int = 0
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Choose the flag of:")
                        .font(.subheadline.weight(.heavy))
                    Text("\(countries[randomNumber])")
                        .font(.largeTitle.weight(.semibold))
                }
                .foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    Button {
                        score(number: number)
                    } label: {
                        Image("\(countries[number])")
                            .renderingMode(.original)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(message, isPresented: $isAlertVisible) {
            Button("Cancel", role: .cancel) {}
            Button("OK") {
                restrat()
            }
        } message: {
            Text("Your Score is: \(score)")
        }
    }
    
    func score(number: Int) {
        if number == randomNumber {
            message = "Congratulations, you guessed right"
            score += 30
        } else {
            message = "Unfortunately you didn't guess"
            score -= 30
        }
        isAlertVisible.toggle()
    }
    
    func restrat() {
        countries.shuffle()
        randomNumber = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
