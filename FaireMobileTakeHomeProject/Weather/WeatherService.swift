//
//  WeatherService.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(for id: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    func getWeather(for id: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard let url = URL(string: "https://www.metaweather.com/api/location/\(id)/") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
