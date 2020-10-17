//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mahmoud Zinji on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            
            VStack(spacing:30) {
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                
                ForEach (0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                VStack {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.title)
                        .shadow(color: .yellow, radius: 4)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number : Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            score -= 1
            scoreTitle = "Wrong!\nThat's the flag of \(countries[number])!"
            
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
