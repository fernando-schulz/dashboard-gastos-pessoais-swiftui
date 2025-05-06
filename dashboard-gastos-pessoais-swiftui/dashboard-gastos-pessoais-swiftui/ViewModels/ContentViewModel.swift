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
    @Published var despesasPorTipo: [DespesaPorTipoModel] = []
    
    private let context: NSManagedObjectContext?
    
    /*
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
            
            self.despesasPorTipo = calcularGastosPorTipo(despesasEntity: resultados)

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
    
    func deletarDespesa(despesa: DespesaMock) {
        guard let context = context else { return }
        
        let fetchRequest: NSFetchRequest<DespesaEntity> = DespesaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", despesa.id.uuidString)
        do {
            if let despesaEntity = try context.fetch(fetchRequest).first {
                context.delete(despesaEntity)
                try context.save()
                print("Despesa deletada com sucesso!")
            } else {
                print(#function, "Despesa não encontrada para o ID: \(despesa.id.uuidString)")
            }
        } catch {
            print("Erro ao deletar despesa: \(error.localizedDescription)")
        }
    }
    
    func calcularGastosPorTipo(despesasEntity: [DespesaEntity]) -> [DespesaPorTipoModel] {
        let agrupado = Dictionary(grouping: despesas) { $0.tipo.nome }
        
        return agrupado.compactMap { (tipoNome, despesasDoTipo) in
            guard let tipo = despesasDoTipo.first?.tipo else { return nil }
            
            let soma = despesasDoTipo.reduce(0) { $0 + $1.valor }
            return DespesaPorTipoModel(nome: tipoNome, valor: soma, cor: tipo.cor)
        }
    }
}
