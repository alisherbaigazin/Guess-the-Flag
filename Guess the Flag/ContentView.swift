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
    @State var round: Int = 0
    @State var gameIsOver = false
    
    @State var selected = -1
    
    @State var rotate = 0
    
    @State var isCorrect = false
    @State var fade = false
    @State var isWrong = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .init(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: .init(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Choose the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text("\(countries[randomNumber])")
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        
//                        FlagButton(image: countries[number], number: number, score: score)
                        Button {
                            withAnimation {
                                score(number)
                                rotate += 360
                            }

                        } label: {
                            Image("\(countries[number])")
                                .renderingMode(.original)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(.degrees(isCorrect && number == selected ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(fade && selected != number ? 0.25 : 1)
                        .rotation3DEffect(.degrees(isWrong && number == selected ? 360 : 0), axis: (x: 0, y: 0, z: 0.5))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.thinMaterial)
                .cornerRadius(15)
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Text("Round: \(round)")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .alert(message, isPresented: $isAlertVisible) {
            Button("Cancel", role: .cancel) {}
            Button("OK") {
                restart()
            }
        } message: {
            Text("Your Score is: \(score)")
        }
        .alert(message, isPresented: $gameIsOver) {
            Button("Yes") {
                round = 0
                score = 0
                restart()
            }
        } message: {
            Text("Your Score: \(score). Do you want to restart?")
        }

    }
    
    func score(_ number: Int) {
        selected = number
        if number == randomNumber {
            message = "Correct"
            score += 30
            isCorrect = true
            fade = true
        } else {
            message = "Wrong! That’s the flag of \(countries[number])"
            score -= 30
            fade = true
            isWrong = true
        }
        round += 1
        if round == 8 {
            gameIsOver.toggle()
        }
        
        if !gameIsOver {
            isAlertVisible.toggle()
        }
    }
    
    func restart() {
        countries.shuffle()
        randomNumber = Int.random(in: 0...2)
        isCorrect = false
        fade = false
        isWrong = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
