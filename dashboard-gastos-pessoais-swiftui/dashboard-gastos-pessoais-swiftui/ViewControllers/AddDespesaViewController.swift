//
//  AddTipoDespesaViewController.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 24/04/25.
//

import SwiftUI

struct AddDespesaViewController: View {
    
    @ObservedObject var viewModel: AddDespesaViewModel
    @Binding var showModal: Bool
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Adicionar Despesa")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
                .padding(.bottom, 25)
            
            CustomTextField(label: "Descrição", text: $viewModel.descricao) {
                TextField("Descrição", text: $viewModel.descricao)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            Button(action: {
                viewModel.salvarDespesa()
                
                if viewModel.errorMessage != nil {
                    showErrorAlert = true
                    return
                }
                
                showModal = false
            }) {
                Text("Salvar")
                    .foregroundColor(Color("TextColor"))
                    .fontWeight(.semibold)
            }
            .frame(width: 175, height: 40)
            .background(Color("Secondary"))
            .cornerRadius(20)
            .accessibilityIdentifier("Salvar Despesa")
            
            Spacer()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Erro"),
                message: Text(viewModel.errorMessage ?? "Não foi possível salvar a despesa despesa."),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.errorMessage = nil
                    showErrorAlert = false
                })
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

#Preview {
    AddDespesaViewControllerPreview()
}

struct AddDespesaViewControllerPreview: View {

    @State private var showModal: Bool = true
    
    var body: some View {
        AddDespesaViewController(viewModel: AddDespesaViewModel(context: PersistenceController.shared.context), showModal: $showModal)
    }
    
}
