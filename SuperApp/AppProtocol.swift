//
//  AppProtocol.swift
//  SuperApp
//
//  Created by Sergei Runov on 08.09.2024.
//

import WeatherApp
import LocationApp

protocol AppProtocol {
    var appName: String { get }
    var appIconName: String { get }
    var viewMode: String { get set }
    
    func setupInteractionMode()
}

extension WeatherApp: AppProtocol {}
extension LocationApp: AppProtocol {}
