//
//  ContentViewModel.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 24/04/25.
//

import CoreData

class ContentViewModel: ObservableObject {
    
    @Published var showModalAddTipoDespesa: Bool = false
    @Published var showModalAddDespesa: Bool = false
    @Published var despesas: [DespesaMock] = []
    
    init(mockDespesas: [DespesaMock]? = nil) {
        if let mockDespesas = mockDespesas {
            self.despesas = mockDespesas
        } else {
            carregarDespesas()
        }
    }
    
    func toogleShowModalAddTipoDespesa() {
        self.showModalAddTipoDespesa.toggle()
    }
    
    func toogleShowModalAddDespesa() {
        self.showModalAddDespesa.toggle()
    }
    
    func carregarDespesas() {
        let request: NSFetchRequest<DespesaEntity> = DespesaEntity.fetchRequest()
        do {
            
        } catch {
            print("Erro ao buscar despesas. \(error.localizedDescription)")
        }
    }
}
