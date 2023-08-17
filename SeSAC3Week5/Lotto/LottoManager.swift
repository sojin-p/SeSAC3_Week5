//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import Foundation
import Alamofire

class LottoManager {
    
    static let shared = LottoManager()
    private init() { }
    
    func callLotto(completionHandler: @escaping (Int, Int) -> Void ) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        //네트워크 통신과 응답을 분리하기
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//                print(value.bnusNo, value.drwtNo3)
                
                completionHandler(value.bnusNo, value.drwtNo3)
                
            }
    }
    
    
}

