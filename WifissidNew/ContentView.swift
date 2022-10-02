//
//  ContentView.swift
//  WifissidNew
//
//  Created by Hitesh Suthar on 30/09/22.
//

import SwiftUI

struct ContentView: View {
    let locationManager = LocationManager()
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button {
                locationManager.fetchCurrentNetwork()
            } label: {
                Text("show ssid")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
