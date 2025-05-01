//
//  TipoDespesaMock.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import Foundation

struct TipoDespesaMock: Identifiable, Hashable {
    var id: UUID = UUID()
    var nome: String
    var cor: String
}

let tipoDespesasMock: [TipoDespesaMock] = [
    TipoDespesaMock(nome: "Alimentação", cor: "#3B82F6"),
    TipoDespesaMock(nome: "Transporte", cor: "#F59E0B"),
    TipoDespesaMock(nome: "Lazer", cor: "#EF4444"),
    TipoDespesaMock(nome: "Saúde", cor: "#10B981")
]
