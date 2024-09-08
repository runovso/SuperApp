//
//  AppSource.swift
//  SuperApp
//
//  Created by Sergei Runov on 07.09.2024.
//

import UIKit
import WeatherApp
import LocationApp

enum App {
    
    // MARK: - Cases
    
    case weather(weatherApiUrl: String, weatherApiKey: String, imageApiUrl: String)
    case location
    
    // MARK: - Computed properties
    
    var controller: UIViewController {
        switch self {
        case .weather(let weatherApiUrl, let weatherApiKey, let imageApiUrl):
            return WeatherApp(weatherApiUrl: weatherApiUrl,
                              weatherApiKey: weatherApiKey,
                              imageApiUrl: imageApiUrl)
        case .location:
            return LocationApp()
        }
    }
}
