//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/16.
//

import UIKit
import Kingfisher

protocol CollectionViewAttributeProtocol {
    
    func configureCollectionView()
    func configureCollectionViewLayout()
    
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    @IBOutlet var notificationButton: UIButton!
    
    
    var list: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    var secondList: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    var thirdList: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    var fourthList: Recommendation = Recommendation(totalPages: 0, page: 0, results: [], totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()
        
        
        //반복문으로 간결하게~
        let id = [872585, 976573, 447365, 346698]
        
        let group = DispatchGroup()
        
        for item in id {
            group.enter()
            RecommendationManager.shared.callRecommendation(id: item) { data in
                //리스트(2차원 배열로 만들어보기)에 데이터넣기
                if item == id[0] { //이런식으로도 괜춘
                    self.list = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
        }

    }
    
    //    override func viewDidAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        showAlert(title: "테스트", message: "테스트입니당", button: "확인") {
//            print("확인버튼을 눌렀습니당")
//            self.posterCollectionView.backgroundColor = .yellow
//        }
//
//    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        //포그라운드 상태에서는 알림이 안 뜨는게 디폴트 : 보고있는데 왜 알림을 줌
        
        //1. 컨텐츠
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 물을 \(Int.random(in: 10...100))모금 주세요"
        content.body = ["아직 레벨 3이에요. 물을 주세요", "어쩌구", "저쩌구"].randomElement()!
        content.badge = 100
        
        //2. 언제 보내?? 일단 타임(초)기반으로 최소기준이 60초임. 알림 폭탄은 안되니까!
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) //반복할거니?
        //2-2 캘린더 기반
        var component = DateComponents()
        component.minute = 5 //매시간 5분마다
        component.hour = 10 //매일 10시 5분마다
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        //3. 보내자!
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger) //교체하고싶으면 아이덴티파이어를 동일하게 하면 됨!
        
        UNUserNotificationCenter.current().add(request) { error in //시스템에게 요청하기
            print(error)
        }
        
    }
    
    func dispatchGroupEnterLeave() {
        
        let group = DispatchGroup() //1.
        
        group.enter() //2. 작업량(레퍼런스 카운트)+1, 특정기능 들어갈게~ (반복되어도 필요한 만큼 넣어야함)
        RecommendationManager.shared.callRecommendation(id: 872585) { data in
            self.list = data
            print("==1==")
            group.leave() //3. -1 떠나보낼게~ (반복되어도 필요한 만큼 넣어야함)
        }
        
        group.enter()
        RecommendationManager.shared.callRecommendation(id: 976573) { data in
            self.secondList = data
            print("==2==")
            group.leave()
        }
        
        group.enter()
        RecommendationManager.shared.callRecommendation(id: 447365) { data in
            self.thirdList = data
            print("==3==")
            group.leave()
        }
        
        group.enter()
        RecommendationManager.shared.callRecommendation(id: 346698) { data in
            self.fourthList = data
            print("==4==")
            group.leave()
        }
        
        group.notify(queue:.main) { //4. 카운트가 0이 될 때 notify가 실행
            self.posterCollectionView.reloadData()
            print("end")
        }
    }
    
    func dispatchGroupNotify() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) { //비동기 안에 비동기(서버통신)가 있음. 그럼 안됨
            RecommendationManager.shared.callRecommendation(id: 872585) { data in
                self.list = data
                print("==1==")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            RecommendationManager.shared.callRecommendation(id: 976573) { data in
                self.secondList = data
                print("==2==")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            RecommendationManager.shared.callRecommendation(id: 447365) { data in
                self.thirdList = data
                print("==3==")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            RecommendationManager.shared.callRecommendation(id: 346698) { data in
                self.fourthList = data
                print("==4==")
            }
        }
        
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
            print("end")
        }
    }
    
    //폰트 내부이름 알아보기
    func fontName() {
        
        for i in UIFont.familyNames {
            print(i)
            for name in UIFont.fontNames(forFamilyName: i) {
                print("====\(name)")
            }
        }
        
        LottoManager.shared.callLotto { bonusNum, num3 in
            print("클로저로 꺼내온 값",bonusNum, num3)
        }
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
        } else if section == 2 {
            return thirdList.results.count
        } else {
            return fourthList.results.count
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
        } else if indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(thirdList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(fourthList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0.7...1), green: CGFloat.random(in: 0.7...1), blue: CGFloat.random(in: 0.7...1), alpha: 1)
        
        return cell
    }
    
    //viewfor~
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLabel.text = "\(indexPath.section + 1)번 타이틀"
            view.titleLabel.font = UIFont(name: "KCC-Chassam", size: 17) //스태틱랫, 이넘 등으로 관리
            
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
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 30) //얘만 새로추가!
        
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







