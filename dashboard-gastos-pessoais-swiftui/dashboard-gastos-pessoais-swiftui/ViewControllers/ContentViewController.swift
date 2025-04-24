//
//  ContentView.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 21/04/25.
//

import CoreData
import SwiftUI

struct ContentViewController: View {

    @Environment(\.managedObjectContext) private var context
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Despesas")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))

                Spacer()

                Menu {
                    Button(
                        "Adicionar Tipo Despesa",
                        action: {
                            viewModel.toogleShowModalAddTipoDespesa()
                        }
                    )

                    /*Button(
                        "Teste Despesa",
                        action: {
                            let request: NSFetchRequest<TipoDespesaEntity> =
                                TipoDespesaEntity.fetchRequest()
                            do {
                                let results = try context.fetch(request)
                                results.forEach { tipo in
                                    print(
                                        "🔎 Tipo: \(tipo.nome ?? "") - Cor: \(tipo.cor ?? "")"
                                    )
                                    /*context.delete(tipo)

                                    do {
                                        try context.save()
                                        print(
                                            "✅ Tipo de despesa excluído com sucesso."
                                        )
                                    } catch {
                                        print(
                                            "❌ Erro ao excluir tipo de despesa: \(error.localizedDescription)"
                                        )
                                    }*/
                                }
                            } catch {
                                print("Erro ao buscar tipos: \(error)")
                            }
                        }
                    )*/
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextColor"))
                }
                .sheet(isPresented: $viewModel.showModalAddTipoDespesa) {
                    AddTipoDespesaViewController(
                        viewModel: AddTipoDespesaViewModel(context: context),
                        showModal: $viewModel.showModalAddTipoDespesa
                    )
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

#Preview {
    ContentViewController(viewModel: ContentViewModel())
}
