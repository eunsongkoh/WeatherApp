//
//  WeatherManager.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
// Call on API to get Weather Data
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> ResponseBody{
        // guard exit early when a condition is not satisfied, rather than continuing further into the code.
        //  If the condition fails, you must exit the scope using return, break, continue, or throw. You cannot just return in the else block without exiting the scope.
        //  Unwrapping Optionals: guard is often used to safely unwrap optionals. If the optional is nil, you can handle the failure immediately and exit.
        //  Clarity: It helps to reduce nesting by handling "failure" cases upfront, allowing you to focus on the "happy path" of your code.
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\("")&units=metric") else {fatalError("MissingURL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        
        // converting json to swift
       let decodedData =  try JSONDecoder().decode(ResponseBody.self, from:data)
        return decodedData
        
    }
}


// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
