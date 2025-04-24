//
//  ContentViewModel.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 24/04/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var showModalAddTipoDespesa: Bool = false
    
    func toogleShowModalAddTipoDespesa() {
        self.showModalAddTipoDespesa.toggle()
    }
}
