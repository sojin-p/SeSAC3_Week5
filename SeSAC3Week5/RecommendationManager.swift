//
//  RecommendationManager.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import Foundation
import Alamofire

class RecommendationManager {
    
    static let shared = RecommendationManager()
    private init() { }
    
    //오펜: 872585 / 엘리멘탈: 976573 / 가오갤: 447365 / 바비: 346698
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdbKey)&language=ko-KR"
        
        //.get 안해도 기본값으로 있음
        AF.request(url).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { response in
                
                switch response.result {
                case .success(let value):
                    completionHandler(value)
//                    self.list = value
//                    self.posterCollectionView.reloadData() //데이터가 달라지는 시점마다 갱신필요!
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    }
}
