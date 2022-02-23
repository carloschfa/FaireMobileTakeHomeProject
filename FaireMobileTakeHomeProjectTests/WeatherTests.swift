//
//  WeatherTests.swift
//  FaireMobileTakeHomeProjectTests
//
//  Created by Carlos Antunes on 22/02/22.
//

import XCTest
@testable import FaireMobileTakeHomeProject

class WeatherTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUp() {
        mockWeatherService = MockWeatherService()
        viewModel = .init(weatherService: mockWeatherService)
    }
    
    func testGetWeatherSuccess() {
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.apiState, .done)
        XCTAssertEqual(viewModel.city, "Toronto")
    }
    
    func testGetWeatherFailure() {
        mockWeatherService.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.apiState, .error(reason: "The operation couldn’t be completed. ( error -1.)"))
    }

    func testGetWeatherWithNoConsolidatedInfo() {
        mockWeatherService.result = .success(WeatherModel(title: "Toronto", consolidatedWeather: []))
        
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.apiState, .error(reason: "Unable to fetch the consolidated weather"))
        
    }
    
}
