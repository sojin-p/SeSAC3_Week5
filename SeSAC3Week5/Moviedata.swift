//
//  Moviedata.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import Foundation

// MARK: - Moviedata
struct Recommendation: Codable {
    let totalPages, page: Int
    let results: [Movie]
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case page, results
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let mediaType: MediaType
    let voteCount: Int
    let video: Bool
    let popularity: Double
    let originalLanguage: String
    let overview: String
    let backdropPath: String?
    let releaseDate: String
    let genreIDS: [Int]
    let title: String
    let posterPath: String?
    let originalTitle: String
    let adult: Bool
    let id: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case video, popularity
        case originalLanguage = "original_language"
        case overview
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case title
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case adult, id
        case voteAverage = "vote_average"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}
