//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/16.
//

import UIKit
import Alamofire

//1. 명확한 오류에대한 정의 - 왜 enum? Error 프로토콜을 채택할 수 있음
//장점: 컴파일 시 오류 타입을 알 수 있음
enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

class CodableViewController: UIViewController {
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var resultText = "Apple"

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        WeatherManager.shared.callRequestString { temp, humidity in
//            self.tempLabel.text = temp
//            self.humidityLabel.text = humidity
//        }
        
        WeatherManager.shared.callRequestCodable { data in
            self.tempLabel.text = "\(Int(data.main.temp - 273.15))도"
            self.humidityLabel.text = "\(data.main.humidity)%"
        } failure: {
            print("얼럿창 띄우기") //왜 여기에서 구현하는가? 매니저에서 하려면, 누가 띄울건지 몰라서..
        }

        
//        WeatherManager.shared.callRequestJSON { json in
//
//            let temp = json["main"]["temp"].doubleValue - 273.15
//            let humidity = json["main"]["humidity"].intValue
//
//            self.tempLabel.text = "\(Int(temp))도"
//            self.humidityLabel.text = "\(humidity)%"
//        }
        
//        fetchTranslateData(source: "ko", target: "en", text: "안녕하세요")

    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        guard let text = dateTextField.text else { return }
        
        //3. 에러 처리
        do { //시도한 실행 결과를 result에 담아라
            let result = try validateUserInputError(text: text) //throw가 있으면 try를 쓸 수 있게 됨
            //callRequest() 이런식으로! 성공시 서버통신 함수 불러라
        } catch {
            print("ERROR") // 스위치문으로 대응하기도..
        }
        
//        //무조건 오류 안나는 상황이라면 강제해제 or 옵셔널도 가능
//        let example = try! validateUserInputError(text: text)
//
//        if example == nil {
//            //열거형에 대한 처리
//        }
        
//        do { //시도한 실행 결과를 result에 담아라
//            let result = try validateUserInputError(text: text) //throw가 있으면 try를 쓸 수 있게 됨
//
//        } catch ValidationError.emptyString { //이 오류일 경우~
//            print(ValidationError.emptyString,".로우밸류 해서 404에러다 하고 띄우거나, 얼럿을 띄우거나 등")
//        } catch ValidationError.isNotInt {
//
//        } catch ValidationError.isNotDate {
//
//        }
        
//        if validateUserInput(text: text) {
//            print("검색 가능, 네트워크 요청 가능")
//        } else {
//            print("검색 불가")
//        }
        
    }
    
    func validateUserInputError(text: String) throws -> Bool { //2.throws 입력: 오류는 던진다..? 화살표 앞쪽

        //빈 칸일 경우
        guard !(text.isEmpty) else {
            print("빈 값")
            throw ValidationError.emptyString //3.열거형에 오류를 던짐
        }

        //입력이 숫자인지 아닌지
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }

        //날짜 형식으로 변환이 되는 지 - 별도로 밑에 함수 만들기 (checkDateFormat)
        guard checkDateFormat(text: text) else {
            print("잘못된 날짜 형식")
            throw ValidationError.isNotDate
        }

        //모든 것이 통과되었으니 트루 리턴
        return true

    }
    
//    func validateUserInput(text: String) -> Bool { //인풋이 유효한지 아닌지 판단하는 함수
//
//        //빈 칸일 경우 -> false 반환
//        guard !(text.isEmpty) else { //text.isEmpty == false
//            print("빈 값")
//            return false //얼리엑싯 : 여기서 걸리면 밑에 안쳐다보고 리턴함.
//        }
//
//        //입력이 숫자인지 아닌지
//        guard Int(text) != nil else {
//            print("숫자 아님")
//            return false
//        }
//
//        //날짜 형식으로 변환이 되는 지 - 별도로 밑에 함수 만들기 (checkDateFormat)
//        guard checkDateFormat(text: text) else {
//            print("잘못된 날짜 형식")
//            return false
//        }
//
//        //모든 것이 통과되었으니 트루 리턴
//        return true
//
//    }
    
    func checkDateFormat(text: String) -> Bool {
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result == nil ? false : true
        
    }
    
//    func fetchTranslateData(source: String, target: String, text: String) {
//
//        print("fetchTranslateData", source, target, text)
//
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500) //validate 디폴트: 200...299 에러 시 왜 에러났는지 모름 -> 200...500으로 범위를 늘리면 이유도 알 수 있다고 함..
//            .responseDecodable(of: Translation.self) { response in
//                //나중에 스위치로 성공일 때, 실패일 때 상태코드 처리 등 예외처리 필요!
//                guard let value = response.value else { return }
//                print(value.message.result.translatedText)
//
//                self.resultText = value.message.result.translatedText
//
//                print("영어 잘 담겼나? ->", self.resultText) //담기는 시점
//
//                self.fetchTranslate(source: "en", target: "ko", text: self.resultText) //담긴 이후에 호출(함수를 두개로 안 만들면 무한 루프.. 지 자신을 또 호출한거라)
//
//            }
//
//    }
//
//    func fetchTranslate(source: String, target: String, text: String) {
//
//        print("fetchTranslateData", source, target, text)
//
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500)
//            .responseDecodable(of: Translation.self) { response in
//
//                guard let value = response.value else { return }
//                print(value.message.result.translatedText)
//
//                self.resultText = value.message.result.translatedText
//
//                print("다시 한국어 최종확인->", self.resultText)
//
//            }
//
//    }
//
//    func fetchLottoData() {
//
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//
//        DispatchQueue.global().async { //네트워크는 오래걸릴 수 있으니까 다른 알바에게 맡기기(스위치 누르기위해)
//            AF.request(url, method: .get).validate()
//                .responseData { response in
//                    guard let value = response.value else { return }
//                    print("responseData:", value)
//
//                    DispatchQueue.main.async {
//                        //뷰에 뿌리는 부분 (레이블에 숫자 출력하기 등)
//                    }
//                }
//        } //AF에서는 DispatchQueue가 내장되어있어서 없어도 가능했던 것.
//
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value) //식판에 담긴 결과로 출력!
//                print(value.bnusNo, value.drwtNo3) //뷰에 뿌리기 텍스트에 보너스넘버 넣는다던지..
//            }
//
//    }

}

// MARK: - Translation
struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}


// MARK: - Lotto
struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}
