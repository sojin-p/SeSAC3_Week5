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
 
        globalAsyncTwo()
        
    }
    
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
