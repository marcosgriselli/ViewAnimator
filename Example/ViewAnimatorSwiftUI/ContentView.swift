//
//  ContentView.swift
//  ViewAnimatorSwiftUI
//
//  Created by Marcos Griselli on 07/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    withAnimation {
                        self.showDetails.toggle()
                    }
                }, label: { Text("Hey") })
                if showDetails {
                    List {
                        Text("Cell")
                        Text("Cell")
                        .transition(.move(edge: .leading))
                        Text("Cell")
                        .transition(.move(edge: .leading))
                    }
                }
            }
        }
        .navigationBarTitle("View Animator")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
