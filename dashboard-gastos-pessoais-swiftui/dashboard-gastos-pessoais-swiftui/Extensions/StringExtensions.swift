//
//  StringExtensions.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 26/04/25.
//

import Foundation

extension String {
    func formatAsCurrency() -> String {
        let numbers = self.filter { ("0"..."9").contains($0) }
        let doubleValue = (Double(numbers) ?? 0) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "R$ 0,00"
    }
}
