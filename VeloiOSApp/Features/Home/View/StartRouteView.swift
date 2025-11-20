//
//  StartRouteView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//

import Foundation
import SwiftUI

struct StartRouteView: View {
    @Environment(\.dismiss) var dismiss
    
    var initialLocation: String
    var finalLocation: String
    
    @State private var bookmarkStyle = "bookmark"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .bold()
                }
                .foregroundStyle(.black)
                
                Button(action: {
                    if bookmarkStyle == "bookmark" {
                        bookmarkStyle = "bookmark.fill"
                    } else {
                        bookmarkStyle = "bookmark"
                    }
                }) {
                    Image(systemName: bookmarkStyle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .bold()
                }
                .foregroundStyle(.black)
            }
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                Text(initialLocation).bold()
                Image(systemName: "arrow.down").bold()
                Text(finalLocation).bold()
            }
            Spacer()
            VeloButton {
                Text("iniciar agora!")
            } action: {
                dismiss()
            }
        }
        .padding()
    }
}
