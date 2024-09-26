//
//  TabMenu.swift
//  Autoclicker
//
//  Created by Vyacheslav on 9/24/24.
//

import SwiftUI

struct TabMenu: View {
    var body: some View {        
        TabView {
            ContentView()
                .tabItem {
                    Label("Click", systemImage: "")
                }
            
            ControlsView()
                .tabItem {
                    Label("Controls (beta)", systemImage: "")
                }
        }
        .frame(width: 350, height: 250)
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabMenu()
            .environmentObject(Controls())
    }
}
