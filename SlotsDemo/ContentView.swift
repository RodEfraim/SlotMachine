//
//  ContentView.swift
//  Slot Machine were your bet amount is always 10 credits. There are only
//  two spinning options; "Spin Middle Row" or "Spin All". The "Spin Middle Row" button will
//  make the middle row the only row to be randomized and scored. A win would result in 100 credits.
//  The "Spin All" button will randomize every slot and score horizontal and diagonal rows. A win
//  using the "Spin All" button would result in 20 credits.
//
//  Created by Rod on 5/10/20.
//  Copyright © 2020 Rodrigo Efraim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = [[0, 1, 2], [0, 2, 0], [1, 0 ,1]]
    @State private var credits = 1000
    private var betAmount = 10
    
    //[0]= 1st row, top,
    //[1] = 2nd row, middle,
    //[2] = 3rd row, bottom,
    //[3] = top left --> bottom right
    //[4] = top right -> bottom left
    @State private var winningRow = [false, false, false, false, false]
    @State private var backgrounds = [Color.white, Color.white, Color.white, Color.white, Color.white]
    
    @State private var row1_diagonal = 1
    @State private var row0_L_diagonal = 3
    @State private var row0_R_diagonal = 4
    @State private var row2_L_diagonal = 4
    @State private var row2_R_diagonal = 3
    
    //@State private var row0_topdiagonal = 1
    
    //Result of "Spin 1 Row" button.
    func result(){
        
        //Check for only middle row
        if self.numbers[1][0] == self.numbers[1][1] && self.numbers[1][0] == self.numbers[1][2]{
            //Won
            self.credits += self.betAmount * 10
            
            //Updates state property backgrounds by setting them green.
            //self.backgrounds[0] = Color.green
            self.backgrounds[1] = Color.green
            //self.backgrounds[2] = Color.green
            self.winningRow[1] = true
            row1_diagonal = 1
            
            //Set state property backgrounds to green using MAP FUNCTION.
            //self.backgrounds = self.backgrounds.map{ _ in Color.green}
        }
        else{
            self.credits -= self.betAmount
            self.winningRow[1] = false
        }
    }
    
    //Checks for all horizontal and diagonal rows. The winning row gets displayed with a green color.
    func resultAll(){
        
        //Check winning
        if self.numbers[0][0] == self.numbers[0][1] && self.numbers[0][0] == self.numbers[0][2]{
            //Wins the top horizontal row.
            
            self.backgrounds[0] = Color.green
            self.winningRow[0] = true
            
            self.row0_L_diagonal = 0
            self.row0_R_diagonal = 0
            self.credits += self.betAmount * 2
        }
        else if self.numbers[1][0] == self.numbers[1][1] && self.numbers[1][0] == self.numbers[1][2]{
            //Wins the middle horizontal row.
            
            self.backgrounds[1] = Color.green
            self.winningRow[1] = true
            
            self.row1_diagonal = 1
            self.credits += self.betAmount * 2
        }
        else if self.numbers[2][0] == self.numbers[2][1] && self.numbers[2][0] == self.numbers[2][2]{
            //Wins the bottom horizontal row.
            
            self.backgrounds[2] = Color.green
            self.winningRow[2] = true
            
            self.row2_L_diagonal = 2
            self.row2_R_diagonal = 2
            self.credits += self.betAmount * 2
        }
        else if self.numbers[0][0] == self.numbers[1][1] && self.numbers[0][0] == self.numbers[2][2]{
            //Wins the top left to bottom right diagonal row.
            
            self.backgrounds[3] = Color.green
            self.winningRow[3] = true
            
            self.row0_L_diagonal = 3
            self.row1_diagonal = 3
            self.row2_R_diagonal = 3
            self.credits += self.betAmount * 2
        }
        else if self.numbers[0][2] == self.numbers[1][1] && self.numbers[0][2] == self.numbers[2][0]{
            //Wins the top right to bottom left diagonal row.
            
            self.backgrounds[4] = Color.green
            self.winningRow[4] = true
            
            self.row0_R_diagonal = 4
            self.row1_diagonal = 4
            self.row2_L_diagonal = 4
            self.credits += self.betAmount * 2
        }
        else{
            //Lost
            self.credits -= self.betAmount
            self.winningRow[0] = false
            self.winningRow[1] = false
            self.winningRow[2] = false
            self.winningRow[3] = false
            self.winningRow[4] = false
        }
    }
    
    var body: some View {
        
        ZStack{
            
            //Background.
            Rectangle().foregroundColor(Color(red:200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
                        
            VStack{
                
                Spacer()
                
                //Title.
                HStack{
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots").fontWeight(.bold).foregroundColor(.white)
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                //Credits Counter
                Text("credits:" + String(credits)).foregroundColor(.black).padding(.all, 10).background(Color.white.opacity(0.5)).cornerRadius(20)
                
                Spacer()
                
                VStack{
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[0][0]], background: $backgrounds[row0_L_diagonal])
                        CardView(symbol: $symbols[numbers[0][1]], background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[0][2]], background: $backgrounds[row0_R_diagonal])
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        
                        //TODO: Maybe add a third parameter here and add line of code onto cardview.swift file.
                        CardView(symbol: $symbols[numbers[1][0]], background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[1][1]], background: $backgrounds[row1_diagonal])
                        CardView(symbol: $symbols[numbers[1][2]], background: $backgrounds[1])
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[2][0]], background: $backgrounds[row2_L_diagonal])
                        CardView(symbol: $symbols[numbers[2][1]], background: $backgrounds[2])
                        CardView(symbol: $symbols[numbers[2][2]], background: $backgrounds[row2_R_diagonal])
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    //1 Row Button
                    Button(action: {
                        
                        //Set state property backgrounds to white.
                        /*self.backgrounds[0] = Color.white
                        self.backgrounds[1] = Color.white
                        self.backgrounds[2] = Color.white*/
                        //Set state property backgrounds to white using the MAP FUNCTION.
                        self.backgrounds = self.backgrounds.map{ _ in Color.white}
                        
                        //Set the images in the middle row to a random pattern.
                        self.numbers[1][0] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[1][1] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[1][2] = Int.random(in:0...(self.symbols.count - 1))
                        
                        print("Symbols count: " + String(self.symbols.count - 1))
                        print(String(self.numbers[1][0]))
                        print(String(self.numbers[1][1]))
                        print(String(self.numbers[1][2]))
                        
                        //Only checks result of middle horizontal row.
                        self.result()
                        print("~~~ Results ~~~")
                        print(String(self.winningRow[0]))
                        print(String(self.winningRow[1]))
                        print(String(self.winningRow[2]))
                        print(String(self.winningRow[3]))
                        print(String(self.winningRow[4]))

                    }) {
                        Text("Spin Middle Row")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.pink)
                            .cornerRadius(20)
                    }
                    
                    //All row buttons.
                    Button(action: {
                        
                        //Set state property backgrounds to white using the MAP FUNCTION.
                        self.backgrounds = self.backgrounds.map{ _ in Color.white}
                        
                        //Set the image in random pattern.
                        self.numbers[0][0] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[0][1] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[0][2] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[1][0] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[1][1] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[1][2] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[2][0] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[2][1] = Int.random(in:0...(self.symbols.count - 1))
                        self.numbers[2][2] = Int.random(in:0...(self.symbols.count - 1))
                        //Set the image in random pattern using MAP FUNCTION.
                        //self.numbers = self.numbers.map({ _ in Int.random(in: 0...self.symbols.count - 1)})
                        
                        //Checks result for all possible rows.
                        self.resultAll()
                        print("~~~ Results ~~~")
                        print(String(self.winningRow[0]))
                        print(String(self.winningRow[1]))
                        print(String(self.winningRow[2]))
                        print(String(self.winningRow[3]))
                        print(String(self.winningRow[4]))
                        
                    }) {
                        Text("Spin all")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

