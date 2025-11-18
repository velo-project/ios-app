//
//  DateExtensions.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 10/09/25.
//

import Foundation

extension Date {
    func formattedBrazilian() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}
