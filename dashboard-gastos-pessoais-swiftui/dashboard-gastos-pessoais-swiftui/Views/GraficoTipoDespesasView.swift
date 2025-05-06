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
    
    var body: some View {
        Chart {
            ForEach(dados, id: \.nome) { item in
                SectorMark(angle: .value("Valor", item.valor), innerRadius: .ratio(0.5), angularInset: 1)
                    .foregroundStyle(Color(hex: item.cor))
                    .annotation(position: .overlay) {
                        Text(item.nome)
                            .font(.caption2)
                            .foregroundColor(Color("TextColor"))
                    }
            }
        }
    }
}

#Preview {
    GraficoTipoDespesasView(dados: despesaPorTipoMock)
}
