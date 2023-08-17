//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
     
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        asyncButton.addTarget(self, action: #selector(asyncButtonClicked), for: .touchUpInside)
    }
    
    @objc func asyncButtonClicked() {
        
        print("async start")
        asyncDownloadImage(imageView: firstImageView, value: "First")
//        asyncDownloadImage(imageView: secondImageView, value: "second")
//        asyncDownloadImage(imageView: thirdImageView, value: "third")
//        asyncDownloadImage(imageView: fourthImageView, value: "fourth")
        print("async end")
        
    }
    
    //일단 다른 알바생에게 작업을 보내고 그 뒤를 당겨서 실행(프린트 먼저 훅 찍히는 거)
    //작업이 언제 끝나는 지 정확한 시점을 알기 어렵다.(손 빠른 알바가 빨리 끝냄 누가 빠른지 모름. 그래두 닭 혼자 하는 것보단 빠름)
    //UI는 메인 쓰레드(닭벼슬)에서 해야한다!(뷰는 늦게 그려져야.. 정 원 만들기 생각하기!)
    func asyncDownloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===", Thread.isMainThread) //메인이 일하고있니?
        
        DispatchQueue.global().async { //여러알바한테 부탁
            print("===2-1===\(value)===", Thread.isMainThread)
            let data = try! Data(contentsOf: Nasa.photo)
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                print("===2-2===\(value)===", Thread.isMainThread)
            }
            print("===2-3===\(value)===", Thread.isMainThread)
        }
        
        print("===3===\(value)===", Thread.isMainThread)
        
    }
        
    @objc func syncButtonClicked() {
        
        print("sync start")
        downloadImage(imageView: firstImageView, value: "first")
        downloadImage(imageView: secondImageView, value: "second")
        downloadImage(imageView: thirdImageView, value: "third")
        downloadImage(imageView: fourthImageView, value: "fourth")
        print("sync end") //동기, 순서대로 실행, 끝나는 지점 알 수 있음(혼자 일 다 하는 상태, 오래 걸림)
        
    }
    
    func downloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===")
        let data = try! Data(contentsOf: Nasa.photo)
        imageView.image = UIImage(data: data)
        print("===2===\(value)===")
        
    }
     
}

extension ViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        
    }
    
    func configureCollectionViewLayout() {
        
    }
    
    
}
