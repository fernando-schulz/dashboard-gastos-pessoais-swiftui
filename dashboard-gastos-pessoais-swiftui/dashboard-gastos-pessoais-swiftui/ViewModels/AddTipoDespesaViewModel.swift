//
//  AddTipoDespesaViewModel.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import SwiftUICore
import CoreData

class AddTipoDespesaViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var nomeTipoDespesa: String = ""
    @Published var selectedColor: Color = .blue
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func salvarTipoDespesa() {
        
        if nomeTipoDespesa.isEmpty {
            errorMessage = "O nome do tipo de despesa é obrigatório."
            return
        }
        
        let newTipoDespesa = TipoDespesaEntity(context: context)
        newTipoDespesa.id = UUID()
        newTipoDespesa.nome = nomeTipoDespesa
        newTipoDespesa.cor = selectedColor.toHex()
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar tipo despesa: \(error.localizedDescription)")
        }
    }
}
