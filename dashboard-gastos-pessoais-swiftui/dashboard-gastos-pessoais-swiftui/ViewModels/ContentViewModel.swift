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
    
    private let context: NSManagedObjectContext?
    
    /*
        - excluir despesa
        - criar gráfico pizza
     */
    
    init(context: NSManagedObjectContext? = nil, mockDespesas: [DespesaMock]? = nil) {
        
        self.context = context
        
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
        guard let context = context else { return }
        
        let fetchRequest: NSFetchRequest<DespesaEntity> = DespesaEntity.fetchRequest()
        do {
            let resultados = try context.fetch(fetchRequest)

            self.despesas = resultados.map { entity in
                DespesaMock(
                    id: entity.id ?? UUID(),
                    descricao: entity.descricao ?? "Sem descrição",
                    valor: entity.valor,
                    data: entity.data ?? Date(),
                    tipo: TipoDespesaMock(id: entity.tipo?.id ?? UUID(), nome: entity.tipo?.nome ?? "Sem nome", cor: entity.tipo?.cor ?? "Sem cor")
                )
            }
        } catch {
            print("Erro ao buscar despesas. \(error.localizedDescription)")
        }
    }
}
