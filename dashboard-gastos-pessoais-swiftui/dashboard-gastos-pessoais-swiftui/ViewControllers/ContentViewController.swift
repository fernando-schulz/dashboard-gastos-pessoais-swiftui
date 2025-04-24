//
//  ContentView.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 21/04/25.
//

import SwiftUI

struct ContentViewController: View {
    
    //@State private var showMenu: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Despesas")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                
                Menu {
                    Button("Add Tipo Despesa", action: {
                        //Abrir tela adicionar tipo despesa
                    })
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextColor"))
                }
                
                /*Button(action: {
                    showMenu = true
                }) {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextColor"))
                }
                .confirmationDialog("Mais opções", isPresented: $showMenu, titleVisibility: .visible) {
                    Button("Add Tipo Despesa") {
                        
                    }
                }*/
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

#Preview {
    ContentViewController()
}
