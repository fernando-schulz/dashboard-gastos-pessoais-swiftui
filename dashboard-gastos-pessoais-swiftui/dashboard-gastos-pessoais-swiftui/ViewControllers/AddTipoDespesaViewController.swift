//
//  AddTipoDespesaViewController.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import SwiftUI

struct AddTipoDespesaViewController: View {
    
    @ObservedObject var viewModel: AddTipoDespesaViewModel
    @Binding var showModal: Bool
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        VStack {
            CustomTextField(label: "Nome", text: $viewModel.nome) {
                TextField("Nome", text: $viewModel.nome)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            ColorPicker("Escolha uma cor", selection: $viewModel.selectedColor)
                .padding()
                .foregroundColor(Color("TextColor"))
            
            Button(action: {
                viewModel.salvarTipoDespesa()
                
                if viewModel.errorMessage != nil {
                    showErrorAlert = true
                    return
                }
            }) {
                Text("Salvar")
                    .foregroundColor(Color("TextColor"))
                    .fontWeight(.semibold)
            }
            .frame(width: 175, height: 40)
            .background(Color("Secondary"))
            .cornerRadius(20)
            .accessibilityIdentifier("Salvar Tipo Despesa")
            
            Spacer()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Erro"),
                message: Text(viewModel.errorMessage ?? "Não foi possível salvar o tipo de despesa."),
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
    AddTipoDespesaViewControllerPreview()
}

struct AddTipoDespesaViewControllerPreview: View {
    
    @State private var showModal: Bool = true
    
    var body: some View {
        AddTipoDespesaViewController(viewModel: AddTipoDespesaViewModel(), showModal: $showModal)
    }
    
}
