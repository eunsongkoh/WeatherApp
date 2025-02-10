//
//  WelcomeView.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    // env variable
    //    In SwiftUI, @EnvironmentObject is a property wrapper used to inject shared, observable data (an ObservableObject) into the SwiftUI environment. It allows different views in your app to access and modify the same piece of data without having to explicitly pass it through the view hierarchy.
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack(spacing: 20){
                    Text("Welcome to the Weather App").bold().font(.title)
                    
                    Text("Please share your current location to get the weather in your area").padding()
                }
                .multilineTextAlignment(.center)
                .padding()
                
                LocationButton(.shareCurrentLocation){
                    // action we want to perform on click
                    locationManager.requestLocation()
                }.cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .padding()
             
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.192, green: 0.175, blue: 0.198)).preferredColorScheme(.dark)
        }.navigationBarHidden(true)
    }
}

#Preview {
    WelcomeView()
}
