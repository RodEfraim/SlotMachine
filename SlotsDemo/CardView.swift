//
//  CardView.swift
//  SlotsDemo
//
//  Created by Rod on 5/17/20.
//  Copyright © 2020 Rodrigo Efraim. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    //Don't set it to anything because this is what will be passed in.
    @Binding var symbol:String
    @Binding var background:Color
    
    var body: some View {
        
        //Two Binding variables are being passed onto the Image structure.
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .cornerRadius(20)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("cherry"), background: Binding.constant(Color.green))
    }
}
