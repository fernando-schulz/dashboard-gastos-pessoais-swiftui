//
//  AddTipoDespesaViewModel.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

//import SwiftUICore
import CoreData

class AddDespesaViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var descricao: String = ""
    @Published var valor: Double = 0
    @Published var tipo: String = ""
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func salvarDespesa() {
        
        if descricao.isEmpty {
            errorMessage = "Informe uma descrição para a despesa."
            return
        }
        
        let newDespesa = DespesaEntity(context: context)
        newDespesa.id = UUID()
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar despesa: \(error.localizedDescription)")
        }
    }
}
