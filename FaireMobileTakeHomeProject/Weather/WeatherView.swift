//
//  ContentView.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.apiState {
                case .loading:
                    loadingView()
                case .error(let reason):
                    errorView(reason)
                case .done:
                    doneView()
                }
                
                Spacer()
            }
            .navigationTitle(viewModel.city)
        }
    }
    
    private func loadingView() -> some View {
        VStack {
            ProgressView("Please wait...")
        }.padding(80)
    }
    
    private func errorView(_ reason: String) -> some View {
        VStack(spacing: 5) {
            Image(systemName: "xmark.octagon")
                .foregroundColor(.red)
            
            Text("There was an error")
            
            Text(reason)
                .foregroundColor(.red)
            
            Button("Try Again") {
                viewModel.fetch()
            }
        }
        .padding(80)
        .multilineTextAlignment(.center)
    }
    
    private func doneView() -> some View {
        NavigationLink(destination: DetailedWeatherView()) {
            VStack {
                HStack {
                    AsyncImage(url: viewModel.iconUrl) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 64, maxHeight: 64)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(viewModel.temperature)
                        .font(.system(size: 64, weight: .regular))
                }
                .padding(.top, 40)
                
                Text(viewModel.stateName)
                    .font(.system(size: 14))
                
                HStack {
                    Text("L: ")
                    Text(viewModel.minimumTemp)
                        .font(.system(size: 24))
                    
                    Text("H: ")
                    Text(viewModel.maximumTemp)
                        .font(.system(size: 24))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherViewModel()
        WeatherView(viewModel: viewModel)
    }
}
