//
//  FaireMobileTakeHomeProjectApp.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import SwiftUI

@main
struct FaireMobileTakeHomeProjectApp: App {
    
    init() {
        appView = .weather
    }
    
    var appView: AppView
    var body: some Scene {
        WindowGroup {
            switch appView {
            case .weather:
                let viewModel = WeatherViewModel()
                WeatherView(viewModel: viewModel)
            case .detailedWeather:
                DetailedWeatherView()
            }
        }
    }
}

enum AppView {
    case weather
    case detailedWeather
}
