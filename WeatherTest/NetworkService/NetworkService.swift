//
//  NetworkService.swift
//  WeatherTest
//
//  Created by Евгений Таракин on 22.05.2025.
//

import Foundation
import Alamofire

final class NetworkService {
        
    func startLoading(complition: @escaping(Model?) -> ()) {
        let url = "http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=LAT,LON&days=7"
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default).responseDecodable(of: Model.self) { result in
            complition(result.value)
        }
    }
    
}
