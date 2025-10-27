//
//  VeloEventCodeComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 27/10/25.
//

import Foundation
import SwiftUI

struct VeloEventCodeComponent: View {
    var code: String
    var eventName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(eventName)
                    .bold()
            }
            .padding(.vertical, 20)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.all, 25)
            
            VStack(alignment: .leading) {
                Text(code)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, 25)
            .background(
                Color.black
                    .clipShape(
                        VeloRoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
                    )
            )
            .foregroundColor(.white)
            .bold()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 3)
    }
}

