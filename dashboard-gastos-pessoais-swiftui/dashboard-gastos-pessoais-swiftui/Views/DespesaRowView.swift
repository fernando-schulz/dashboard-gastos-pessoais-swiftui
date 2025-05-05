//
//  DespesaRowView.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 05/05/25.
//

import SwiftUI

struct DespesaRowView: View {
    let despesa: DespesaMock
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(despesa.descricao)
                    .font(.headline)
                    .foregroundColor(Color(hex: despesa.tipo.cor))
                
                Spacer()
                
                Text(despesa.valor.formatted(.currency(code: "BRL").precision(.fractionLength(2))))
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
                    .foregroundColor(Color(hex: despesa.tipo.cor))
            }
        }
        .padding()
        .background(Color("Primary"))
        .cornerRadius(12)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                withAnimation {
                    onDelete()
                }
            } label: {
                Label("Deletar", systemImage: "trash")
            }
        }
    }
}


#Preview {
    DespesaRowView(despesa: despesaMock, onDelete: {})
}
