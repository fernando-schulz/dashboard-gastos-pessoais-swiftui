//
//  DespesaMock.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import Foundation

struct DespesaMock: Identifiable, Hashable {
    var id: UUID = UUID()
    var descricao: String
    var valor: Double
    var data: Date
    var tipo: TipoDespesaMock
}

let despesasMock: [DespesaMock] = [
    DespesaMock(descricao: "Almoço no restaurante", valor: 35.50, data: Date(), tipo: tipoDespesasMock[0]),
    DespesaMock(descricao: "Uber para casa", valor: 18.00, data: Date(), tipo: tipoDespesasMock[1]),
    DespesaMock(descricao: "Cinema", valor: 25.00, data: Date(), tipo: tipoDespesasMock[2]),
    DespesaMock(descricao: "Farmácia", valor: 42.35, data: Date(), tipo: tipoDespesasMock[3]),
    DespesaMock(descricao: "Combustível mês de Maio", valor: 312.50, data: Date(), tipo: tipoDespesasMock[1])
]
