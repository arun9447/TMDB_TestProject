//
//  Color+Extension.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// Extension to add color-to-hex and hex-to-color functionality
extension Color {
    // Convert Color to Hex String
    func toHex() -> String {
        let uiColor = UIColor(self)
        let components = uiColor.cgColor.components ?? [0, 0, 0, 0]
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }

    // Convert Hex String to Color (supports #RRGGBB format)
    init(hex: String) {
        let hexSanitized = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexSanitized)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }

    // Provide a human-readable color name (optional)
    var hexName: String {
        switch self {
        case .red: return "Red"
        case .green: return "Green"
        case .blue: return "Blue"
        case .orange: return "Orange"
        case .yellow: return "Yellow"
        case .pink: return "Pink"
        case .purple: return "Purple"

        default: return "Custom"
        }
    }
    
    func darker() -> Color {
            self.opacity(0.7)
        }
    //    // Adjust color to be a lighter shade
        func lighter() -> Color {
            self.opacity(0.3)
        }
}
