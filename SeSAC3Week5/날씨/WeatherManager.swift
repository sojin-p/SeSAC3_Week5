//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    private init() { }
    
    func callRequestCodable(success: @escaping (Weather) -> Void, failure: @escaping () -> Void ) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: Weather.self) { response in
                
                switch response.result { //result는 뭔가요? -> 알라모파이어에 있는 듯
                case .success(let value): success(value)
                case .failure(let error):
                    print(error)
                    failure() //호출만 하겠다 (밖에서 쓰겠다)
                }
            }
    }
    
    func callRequestJSON(completionHandler: @escaping (JSON) -> Void ) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestString(completionHandler: @escaping (String, String) -> Void ) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                let tempString = "\(temp)도 입니다."
                let humidityString = "습도는 \(humidity)% 입니다."
                
                completionHandler(tempString, humidityString)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
