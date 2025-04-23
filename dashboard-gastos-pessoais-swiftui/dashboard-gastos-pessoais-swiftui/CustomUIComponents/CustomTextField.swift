//
//  CustomTextField.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import SwiftUI

struct CustomTextField<Content: View>: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    let content: () -> Content
    
    private var shouldShowLabel: Bool {
        !text.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            if shouldShowLabel {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: text)
            }
            
            content()
        }
        .frame(height: 25)
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
    }
}

#Preview {
    CustomTextFieldPreview()
}

struct CustomTextFieldPreview: View {
    @State private var text: String = ""
    
    var body: some View {
        CustomTextField(label: "Label", placeholder: "Placeholder", text: $text, content: { TextField("Teste", text: $text) })
    }
}
