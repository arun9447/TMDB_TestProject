//
//  SettingsView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// MARK: -  SettingsView
struct SettingsView: View {
    @AppStorage("selectedThemeColor") private var selectedThemeColorHex: String = "#FFFFFF" // Hex code for selected color
    @State private var selectedColor: Color = Color("#FFFFFF") // Default to white
    @Binding var showSettings: Bool // Binding to dismiss the settings view

    let colorOptions: [Color] = [
        .red, .green, .blue, .orange, .yellow, .pink, .purple
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose Theme Color")) {
                    ForEach(colorOptions, id: \.self) { color in
                        Button(action: {
                            // Set the selected color and dismiss settings
                            selectedColor = color
                            selectedThemeColorHex = color.toHex() // Store the selected color as hex
                            showSettings = false
                        }) {
                            HStack {
                                Rectangle()
                                    .fill(color)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(5)
                                Text(color.hexName) // Display color name or hex
                                Spacer()
                                if selectedColor == color {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }

                Section {
                    Button("Reset to Default Theme") {
                        // Reset to default (white)
                        selectedColor = .white
                        selectedThemeColorHex = "#FFFFFF"
                        showSettings = false // Dismiss settings view
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
        .onAppear {
            selectedColor = Color(hex: selectedThemeColorHex) // Update the selected color from AppStorage
        }
    }
}

