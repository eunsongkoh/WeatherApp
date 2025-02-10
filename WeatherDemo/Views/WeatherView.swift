//
//  WeatherView.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading){
                VStack{
                }
                
                VStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text(weather.name)
                            .bold().font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            VStack(spacing: 20){
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                
                                Text(weather.weather[0].main)
                                
                            }.frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.feelsLike.roundDouble() + "°").font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer().frame(height: 80)
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_640.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                            
                        }placeholder: {
                            ProgressView()
                        }
                        
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    
                }.padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Weather Now")
                            .bold().padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "thermometer.medium", name:"Min Temp", value: (
                                weather.main.tempMin.roundDouble() + "°"
                            ))
                            Spacer()
                            WeatherRow(logo: "thermometer.medium", name:"Max Temp", value: (
                                weather.main.tempMax.roundDouble() + "°"
                            ))
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name:"Wind Speed", value: (
                                weather.wind.speed.roundDouble() + "m/s"
                            ))
                            Spacer()
                            WeatherRow(logo: "humidity", name:"Humidity", value: (
                                weather.main.humidity.roundDouble() + "%"
                            ))
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(red: 0.192, green: 0.175, blue: 0.198))
                        .background(.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                }
                
            }.edgesIgnoringSafeArea(.bottom)
                .background(Color(red: 0.192, green: 0.175, blue: 0.198)).preferredColorScheme(.dark)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: WelcomeView()) {
                            Image(systemName: "arrowshape.backward.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                                
                        }
                    }
                }
            
        }
    }
}

#Preview {
    // our preview needs a weather variable as well in order to work if we see an error that we having a missing argument
    WeatherView(weather: previewWeather)
}

