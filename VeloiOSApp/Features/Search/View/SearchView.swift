//
//  SearchView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 16/08/25.
//

import SwiftUI

struct SearchView: View {
    @Binding var queryText: String
    
    var body: some View {
        NavigationStack {
            List {
                Text("Lorem Ipsum")
            }
            .navigationTitle("buscar")
            .searchable(text: $queryText)
        }
    }
}

//#Preview {  
//    SearchView()
//}
