//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    // how we init something in SwiftUI
    // @StateObject property wrapper so that the view can be notified every time the published variables in our locationManager are updated
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            // gets the location from the locationManager class
            if let location = locationManager.location{
                if let weather = weather {
                    WeatherView(weather: weather)
                }else {
                    LoadingView()
                        .task {
                            // performs async view
                            // similar to onAppear
                            // performs async task when view appears
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                     } else {
                    if locationManager.isLoading {
                        // see a progress bar
                        LoadingView()
                    } else {
                        // if we do not have the current user location we will display the welcome message
                        WelcomeView().environmentObject(locationManager)
                    }
                }
        }.background(Color(red: 0.192, green: 0.175, blue: 0.198)).preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
