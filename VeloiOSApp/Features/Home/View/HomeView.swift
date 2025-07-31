//
//  HomeView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        Text("Hello, Home Page!")
        Button("Ir para login") {
            router.navigate(to: .login)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
