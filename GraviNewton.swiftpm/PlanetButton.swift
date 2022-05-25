//
//  File.swift
//  GraviNewton
//
//  Created by Cynara Costa on 11/04/22.
//

import SwiftUI

struct PlanetButton: View {
    
    @Binding var gravity: Float
    var title: String
    var image: String
    
    var body: some View {
        Button {
            
            if title == "Earth"{
                gravity = 9.8
            } else if title == "Moon"{
                gravity = 1.62
            } else {
                gravity = 24.79
            }
            
        } label: {
            VStack(spacing: 3) {
                Text(title)
                    .font(.system(size: 10, weight: .semibold, design: .default))
                    .foregroundColor(Color("mediumGray"))
                Image(image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
        }
        .frame(width: 65, height: 65, alignment: .center)
        .background(Color.white)
        .cornerRadius(4)
    }
    
}
