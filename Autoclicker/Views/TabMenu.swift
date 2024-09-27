//
//  TabMenu.swift
//  Autoclicker
//
//  Created by Vyacheslav on 9/24/24.
//

import SwiftUI

struct TabMenu: View {
    @StateObject var controls = Controls()
    
    var body: some View {
        TabView {
            ContentView()
                .environmentObject(controls)
                .tabItem {
                    Text("Click")
                }
            
            ControlsView()
                .environmentObject(controls)
                .tabItem {
                    Text("Controls (beta)")
                }
            
        }
        .frame(width: 500, height: 350)
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabMenu()
    }
}
