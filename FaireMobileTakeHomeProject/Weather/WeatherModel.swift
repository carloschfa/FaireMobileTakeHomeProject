//
//  Models.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import Foundation

struct WeatherModel: Codable {
    let title: String
    let consolidatedWeather: [ConsolidatedWeather]
    
    enum CodingKeys: String, CodingKey {
        case title,
        consolidatedWeather = "consolidated_weather"
    }
}

struct ConsolidatedWeather: Codable {
    let stateName: String
    let minimum: Float
    let maximum: Float
    let current: Float
    let stateAbbreviation: String
    
    enum CodingKeys: String, CodingKey {
        case stateName = "weather_state_name",
        minimum = "min_temp",
        maximum = "max_temp",
        current = "the_temp",
        stateAbbreviation = "weather_state_abbr"
    }
}
