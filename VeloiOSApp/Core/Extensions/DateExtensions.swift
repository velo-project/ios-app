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

    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

// MARK: - String Extension for Date Conversion

// Formatter created once for efficiency
private let iso8601Formatter = ISO8601DateFormatter()

extension String {
    func timeAgoDisplay() -> String {
        // Attempt to convert the string to a Date
        guard let date = iso8601Formatter.date(from: self) else {
            // If parsing fails, return a sensible default
            return "agora mesmo"
        }
        // If successful, use the existing Date extension
        return date.timeAgoDisplay()
    }
}
