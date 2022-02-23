//
//  MockWeatherService.swift
//  FaireMobileTakeHomeProjectTests
//
//  Created by Carlos Antunes on 22/02/22.
//

@testable import FaireMobileTakeHomeProject

final class MockWeatherService: WeatherServiceProtocol {
    
    var result: Result<WeatherModel, Error> = .success(WeatherModel(
        title: "Toronto",
        consolidatedWeather: [
            ConsolidatedWeather(stateName: "Rain", minimum: 1, maximum: 30, current: 20, stateAbbreviation: "t")
        ])
    )
    
    func getWeather(for id: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        completion(result)
    }
    
    
}
