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
    @Published var totalGastos: Double = 0

    private let context: NSManagedObjectContext?

    init(
        context: NSManagedObjectContext? = nil,
        mockDespesas: [DespesaMock]? = nil,
        mockDespesasPorTipo: [DespesaPorTipoModel]? = nil
    ) {

        self.context = context
        
        if let mockDespesasPorTipo = mockDespesasPorTipo {
            self.despesasPorTipo = mockDespesasPorTipo
        } else {
            calcularGastosPorTipo()
        }

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
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "data", ascending: false)
        ]
        
        do {
            let resultados = try context.fetch(fetchRequest)

            self.despesas = resultados.map { entity in
                DespesaMock(
                    id: entity.id ?? UUID(),
                    descricao: entity.descricao ?? "Sem descrição",
                    valor: entity.valor,
                    data: entity.data ?? Date(),
                    tipo: TipoDespesaMock(
                        id: entity.tipo?.id ?? UUID(),
                        nome: entity.tipo?.nome ?? "Sem nome",
                        cor: entity.tipo?.cor ?? "Sem cor"
                    )
                )
            }
        } catch {
            print("Erro ao buscar despesas. \(error.localizedDescription)")
        }
    }

    func deletarDespesa(despesa: DespesaMock) {
        guard let context = context else { return }

        let fetchRequest: NSFetchRequest<DespesaEntity> =
            DespesaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id == %@",
            despesa.id.uuidString
        )
        do {
            if let despesaEntity = try context.fetch(fetchRequest).first {
                context.delete(despesaEntity)
                try context.save()
                print("Despesa deletada com sucesso!")
                carregarDespesas()
                calcularGastosPorTipo()
            } else {
                print(
                    #function,
                    "Despesa não encontrada para o ID: \(despesa.id.uuidString)"
                )
            }
        } catch {
            print("Erro ao deletar despesa: \(error.localizedDescription)")
        }
    }
    
    func deletarDespesas() {
        guard let context = context else { return }
        
        let request: NSFetchRequest<DespesaEntity> = DespesaEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            results.forEach { despesa in
                context.delete(despesa)

                do {
                    try context.save()
                    print("✅ Despesas excluídas com sucesso.")
                    carregarDespesas()
                    calcularGastosPorTipo()
                } catch {
                    print("❌ Erro ao excluir despesas: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar despesas: \(error)")
        }
    }

    func calcularGastosPorTipo() {
        guard let context = context else { return }

        let fetchRequest: NSFetchRequest<DespesaEntity> =
            DespesaEntity.fetchRequest()
        do {
            let despesasEntity = try context.fetch(fetchRequest)

            let agrupado = Dictionary(grouping: despesasEntity) {
                $0.tipo?.nome ?? "Sem nome"
            }

            totalGastos = 0
            self.despesasPorTipo = agrupado.compactMap { (tipoNome, despesasDoTipo) in
                guard let tipo = despesasDoTipo.first?.tipo else { return nil }

                let soma = despesasDoTipo.reduce(0) { $0 + $1.valor }
                totalGastos += soma
                return DespesaPorTipoModel(
                    nome: tipoNome,
                    valor: soma,
                    cor: tipo.cor ?? "#FFFFFF"
                )
            }
        } catch {
            print("Erro ao buscar despesas. \(error.localizedDescription)")
        }
    }
    
    var despesasAgrupadasPorDia: [(data: Date, despesas: [DespesaMock])] {
        let agrupado = Dictionary(grouping: despesas) { despesa in
            Calendar.current.startOfDay(for: despesa.data)
        }
        
        return agrupado
            .map { ($0.key, $0.value )}
            .sorted { $0.data > $1.data }
    }
}
