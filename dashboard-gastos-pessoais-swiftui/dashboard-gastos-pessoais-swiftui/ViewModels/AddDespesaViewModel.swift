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
    @Published var valorText: String = ""
    @Published var dataSelecionada: Date = Date()
    @Published var tiposDespesas: [TipoDespesaMock] = []
    @Published var tipoSelecionado: TipoDespesaMock?
    
    var onSave: (() -> Void)?

    private let context: NSManagedObjectContext?

    init(
        context: NSManagedObjectContext? = nil,
        mockTipoDespesas: [TipoDespesaMock]? = nil,
        onSave: (() -> Void)? = nil
    ) {
        self.context = context

        if let mockTipoDespesas = mockTipoDespesas {
            self.tiposDespesas = mockTipoDespesas
        } else {
            carregarTiposDespesas()
        }
        
        self.onSave = onSave
    }

    func salvarDespesa() {
        guard let context = context else { return }

        if descricao.isEmpty {
            errorMessage = "Informe uma descrição para a despesa."
            return
        }
        
        if valorText.isEmpty {
            errorMessage = "Informe um valor para a despesa."
            return
        }
        
        if tipoSelecionado == nil {
            errorMessage = "Selecione um tipo de despesa."
            return
        }
        
        if let tipoSelecionado = tipoSelecionado {            
            let fetchRequest: NSFetchRequest<TipoDespesaEntity> = TipoDespesaEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", tipoSelecionado.id as CVarArg)
            
            if let tipoEncontrado = try? context.fetch(fetchRequest).first {
                let newDespesa = DespesaEntity(context: context)
                newDespesa.id = UUID()
                newDespesa.data = dataSelecionada
                newDespesa.descricao = descricao
                newDespesa.tipo = tipoEncontrado
                newDespesa.valor  = valorText.currencyToDouble()
            }
        }

        do {
            try context.save()
            onSave?()
        } catch {
            print("Erro ao salvar despesa: \(error.localizedDescription)")
        }
    }

    func carregarTiposDespesas() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<TipoDespesaEntity> =
            TipoDespesaEntity.fetchRequest()

        do {
            let resultados = try context.fetch(fetchRequest)
            // Converte entidades reais para mocks para usar na UI de forma unificada
            self.tiposDespesas = resultados.map { entity in
                TipoDespesaMock(
                    id: entity.id ?? UUID(),
                    nome: entity.nome ?? "Sem nome",
                    cor: entity.cor ?? "#FFFFFF"
                )
            }
        } catch {
            print(
                "Erro ao buscar tipos de despesas: \(error.localizedDescription)"
            )
        }
    }
}
