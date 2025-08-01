//
//  Font.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import Foundation
import SwiftUI

extension Font {
    public static var largeTitle: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    public static var title: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    public static var headline: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    
    public static var subheadline: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }
    
    public static var body: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    public static var callout: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    public static var footnote: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
    
    public static var caption: Font {
        return Font.custom("Outfit", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }
    
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "Outfit"
        switch weight {
        case .bold: font = "Outfit"
        case .heavy: font = "Outfit"
        case .light: font = "Outfit"
        case .medium: font = "Outfit"
        case .semibold: font = "Outfit"
        case .thin: font = "Outfit"
        case .ultraLight: font = "Outfit"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
