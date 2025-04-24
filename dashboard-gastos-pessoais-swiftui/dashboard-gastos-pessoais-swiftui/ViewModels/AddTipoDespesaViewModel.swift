//
//  AddTipoDespesaViewModel.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import SwiftUICore

class AddTipoDespesaViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var nome: String = ""
    @Published var selectedColor: Color = .blue
    @Environment(\.managedObjectContext) var context
    
    func salvarTipoDespesa() {
        
        if nome.isEmpty {
            errorMessage = "O nome do tipo de despesa é obrigatório."
            return
        }
        
        let newTipoDespesa = TipoDespesaEntity(context: context)
        newTipoDespesa.id = UUID()
        newTipoDespesa.nome = nome
        newTipoDespesa.cor = selectedColor.toHex()
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar tipo despesa: \(error.localizedDescription)")
        }
    }
}
