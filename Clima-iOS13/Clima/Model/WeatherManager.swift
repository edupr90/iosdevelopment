//
//  WeatherManager.swift
//  Clima
//b13baeedcb3557f83cba623afb506aa0
//  Created by Eduardo Velez on 4/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didWeatherUpdate(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error:Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b13baeedcb3557f83cba623afb506aa0&units=imperial"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequesr(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequesr(with: urlString)
    }
    
    func performRequesr(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didWeatherUpdate(self,weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
    
}



