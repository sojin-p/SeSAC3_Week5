//
//  WeatherData.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let main: Main
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
    let base: String
    let dt: Int
    let name: String
    let coord: Coord
    let visibility, timezone: Int
    let weather: [WeatherElement]
    let cod, id: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let humidity, grndLevel: Int
    let tempMin, feelsLike: Double
    let pressure: Int
    let tempMax: Double
    let seaLevel: Int
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case humidity
        case grndLevel = "grnd_level"
        case tempMin = "temp_min"
        case feelsLike = "feels_like"
        case pressure
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case temp
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunset, type: Int
    let country: String
    let sunrise, id: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let icon: String
    let id: Int
    let main, description: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed, gust: Double
    let deg: Int
}
