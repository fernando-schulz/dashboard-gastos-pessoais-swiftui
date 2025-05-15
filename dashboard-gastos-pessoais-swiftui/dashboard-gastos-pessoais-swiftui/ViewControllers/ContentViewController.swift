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

                    Button(
                        "Excluir Despesas",
                        action: {
                            viewModel.deletarDespesas()
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
                        viewModel: AddDespesaViewModel(context: context, onSave: { viewModel.carregarDespesas()
                            viewModel.calcularGastosPorTipo()
                        }),
                        showModal: $viewModel.showModalAddDespesa,
                        
                    )
                }
            }
            
            VStack {
                Text("Total: \(viewModel.totalGastos.formatted(.currency(code: "BRL").precision(.fractionLength(2))))")
                    .foregroundColor(Color("TextColor"))
                    .font(.title3)
                    .fontWeight(.bold)
                
                GraficoTipoDespesasView(dados: viewModel.despesasPorTipo)
            }
            .padding()
            .background(Color("Primary"))
            .cornerRadius(12)
            
            Divider()
                .background(Color("TextColor"))

            List {
                ForEach(viewModel.despesasAgrupadasPorDia, id: \.data) { grupo in
                    Section(
                        header: Text(grupo.data.formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(Color("TextColor"))
                            .font(.subheadline)
                    ) {
                        ForEach(grupo.despesas) { despesa in
                            DespesaRowView(despesa: despesa) {
                                viewModel.deletarDespesa(despesa: despesa)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            
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
        viewModel: ContentViewModel(context: PersistenceController.shared.context, mockDespesas: despesasMock, mockDespesasPorTipo: despesaPorTipoMock)
    )
}
