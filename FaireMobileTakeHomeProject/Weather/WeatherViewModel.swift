//
//  ViewModel.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import Foundation

class WeatherViewModel: ObservableObject {
    private let service: WeatherServiceProtocol
    
    @Published var city: String = "Loading..."
    @Published var temperature: String = "-°"
    @Published var stateName: String = "-"
    @Published var minimumTemp: String = "-°"
    @Published var maximumTemp: String = "-°"
    @Published var iconUrl: URL?
    @Published var apiState: APIState = .loading
    
    enum APIState: Equatable {
        case done, loading, error(reason: String)
    }
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.service = weatherService
        fetch()
    }
    
    func fetch() {
        self.apiState = .loading
        
        service.getWeather(for: "4118") { result in
            switch result {
            case .success(let weatherModel):
                self.updateUI(with: weatherModel)
            case .failure(let error):
                self.apiState = .error(reason: error.localizedDescription)
            }
        }
    }
    
    private func updateUI(with weatherModel: WeatherModel) {
        guaranteeMainThread {
            self.city = weatherModel.title
            if let consolidatedWeather = weatherModel.consolidatedWeather.first {
                self.stateName = consolidatedWeather.stateName
                self.temperature = "\(Int(consolidatedWeather.current))°"
                self.minimumTemp = "\(Int(consolidatedWeather.minimum))°"
                self.maximumTemp = "\(Int(consolidatedWeather.maximum))°"
                self.iconUrl = URL(string: "https://www.metaweather.com/static/img/weather/png/\(consolidatedWeather.stateAbbreviation).png")!
                self.apiState = .done
            } else {
                self.apiState = .error(reason: "Unable to fetch the consolidated weather")
            }
        }
    }
}

