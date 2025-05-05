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
                        "Adicionar Despesa",
                        action: {
                            viewModel.toogleShowModalAddDespesa()
                        }
                    )

                    Button(
                        "Adicionar Tipo Despesa",
                        action: {
                            viewModel.toogleShowModalAddTipoDespesa()
                        }
                    )

                    /*Button(
                        "Teste Tipo Despesa",
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

                    Button(
                        "Teste Despesa",
                        action: {
                            let request: NSFetchRequest<DespesaEntity> =
                                DespesaEntity.fetchRequest()
                            do {
                                let results = try context.fetch(request)
                                results.forEach { despesa in
                                    print(
                                        "🔎 Descrição: \(despesa.descricao ?? "") - Valor: \(despesa.valor)"
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
                    )
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
                .sheet(isPresented: $viewModel.showModalAddDespesa) {
                    AddDespesaViewController(
                        viewModel: AddDespesaViewModel(context: context),
                        showModal: $viewModel.showModalAddDespesa
                    )
                }
            }

            Spacer()
            
            Divider()
                .background(Color("TextColor"))

            List {
                Section {
                    ForEach(viewModel.despesas) { despesa in
                        DespesaRowView(despesa: despesa) {
                            viewModel.deletarDespesa()
                        }
                        /*VStack(alignment: .leading) {
                            HStack {
                                Text(despesa.descricao)
                                    .font(.headline)
                                    .foregroundColor(
                                        Color(hex: despesa.tipo.cor)
                                    )
                                
                                Spacer()
                                
                                Text("\(despesa.valor.formatted(.currency(code: "BRL").precision(.fractionLength(2))))")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("TextColor"))
                            }

                            HStack {
                                Text(despesa.data, style: .date)
                                    .font(.footnote)
                                    .foregroundColor(Color("TextColor"))
                                
                                Spacer()

                                Text(despesa.tipo.nome)
                                    .font(.subheadline)
                                    .foregroundColor(
                                        Color(hex: despesa.tipo.cor)
                                    )
                            }
                        }
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(12)
                        .swipeActions(content: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    viewModel.deletarDespesa()
                                }
                            } label: {
                                Label("Deletar", systemImage: "trash")
                            }
                        }*/
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .colorScheme(.dark)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

#Preview {
    ContentViewController(
        viewModel: ContentViewModel(context: PersistenceController.shared.context, mockDespesas: despesasMock)
    )
}
