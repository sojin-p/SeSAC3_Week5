//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

protocol CollectionViewAttributeProtocol {
    
    func configureCollectionView()
    func configureCollectionViewLayout()
    
}


class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    var list: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    var secondList: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoManager.shared.callLotto { bonusNum, num3 in
//            print("클로저로 꺼내온 값",bonusNum, num3)
//        }

        configureCollectionView()
        configureCollectionViewLayout()
        
        callRecommendation(id: 872585) { data in
            self.list = data
            self.posterCollectionView.reloadData() //여기가 없으면 .. 뭐가 먼저 통신될지 모르니까 운에맡겨야 됨
        }
        
        callRecommendation(id: 976573) { data in
            self.secondList = data
            self.posterCollectionView.reloadData()
        }

    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        showAlert(title: "테스트", message: "테스트입니당", button: "확인") {
//            print("확인버튼을 눌렀습니당")
//            self.posterCollectionView.backgroundColor = .yellow
//        }
        
    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(list.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(secondList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0.7...1), green: CGFloat.random(in: 0.7...1), blue: CGFloat.random(in: 0.7...1), alpha: 1)
        
        return cell
    }
    
    //viewfor~
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLabel.text = "테스트 섹션"
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
            
    }
    
}

extension PosterViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() { //여기저기서 다 쓰니까 다 묶을거면 컨피규얼어트리뷰트 같은 이름으로도..
        
        //Protocol as Type 타입으로써의 프로토콜(밑에 적어둠)
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier) //리유저블 뷰 등록할 때 - forSupplementaryViewOfKind:헤더로쓸겨? 푸터로쓸겨? -> UICollectionView쓰고 점 찍으면 나옴
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50) //얘만 새로추가!
        
        posterCollectionView.collectionViewLayout = layout
    }
    
}

//posterCollectionView.delegate = self 딜리게이트와 셀프의 타입이 다른데 어떻게 되지?
//protocol Test {
//    func test()
//}
//
//class A: Test {
//    func test() {
//
//    }
//}
//
//class B: Test {
//    func test() {
//
//    }
//}
//
//class C: A {
//
//}

//let value: A = C() //C의 인스턴스를 담아주면, 타입이 A클래스 타입이 됨: C가 A를 상속받으니까

//프로토콜의 고급 특징: 타입으로써의 기능 Protocol as Type
//테스트라는 프로토콜을 가지고있는 클래스든 구조체를 넣을 수 있다.
//let example: Test = A()

/*
 posterCollectionView.delegate = self
 delegate는 UICollectionViewDelegate 프로토콜을 타입처럼 쓰고있기 때문에,
 posterCollectionView가 UICollectionViewDelegate를 채택하고 있으므로 self가 가능한 것!
 */






