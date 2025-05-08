//
//  GraficoTipoDespesasView.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 06/05/25.
//

import Charts
import SwiftUI

struct GraficoTipoDespesasView: View {
    
    let dados: [DespesaPorTipoModel]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Chart {
            ForEach(dados, id: \.nome) { item in
                SectorMark(angle: .value("Valor", item.valor), innerRadius: .ratio(0.5), angularInset: 1)
                    .foregroundStyle(Color(hex: item.cor))
            }
        }
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            ForEach(dados, id: \.nome) { item in
                HStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(hex: item.cor))
                        .frame(width: 10, height: 18)
                    
                    Text(item.nome)
                        .font(.caption)
                        .foregroundColor(Color("TextColor"))
                }
            }
        }
    }
}

#Preview {
    GraficoTipoDespesasView(dados: despesaPorTipoMock).background(Color("Primary"))
}
