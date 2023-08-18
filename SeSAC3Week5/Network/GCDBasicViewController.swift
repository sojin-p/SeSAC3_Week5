//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        dispatchGroup()
        
    }
    
    func dispatchGroup() {
        
        let group = DispatchGroup() //1.
        
        DispatchQueue.global().async(group: group) { //2. group 매개변수 하나 가져와서 위 상수 넣기(그룹 등록)
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 301...400 {
                print(i, terminator: " ")
            }
        }
        
        //3.
        group.notify(queue: .main) { //queue: 신호를 어디서 받을건지(보통 메인)
            print("할 일 끝났다") //갱신, 화면전환, 팝업창 등의 코드를 여기에~!
        }
        
    }
    
    //--------------------------------------------
    
    func globalAsyncTwo() {
        
        print("Start")
        
        for i in 1...100 {
        
            DispatchQueue.global().async { //알바 백명쓰는 느낌(작업단위가 작아서)
                sleep(1)
                print(i, terminator: " ")
            }
            
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    //--------------------------------------------
    
    func globalAsync() {
        print("Start")
        
        DispatchQueue.global().async { //네트워크 통신처럼 오래걸릴 일이 있는 것들은 동시에 해야 시간이 줄어든다.
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    //--------------------------------------------
    
    func globalSync() {
        print("Start")
        
        DispatchQueue.global().sync {
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    //--------------------------------------------
    
    func serialAsync() {
        print("Start")

        DispatchQueue.main.async {
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }

        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }

        print("End")
    }
    
    //--------------------------------------------
    
    func serialSync() {
        print("Start")

        for i in 1...10 {
            sleep(1)
            print(i, terminator: " ")
        }

        DispatchQueue.main.sync { //데드락 : 지금은 쓰지 말자
            for i in 11...20 {
                sleep(1)
                print(i, terminator: " ")
            }
        }

        print("End")
    }
}
