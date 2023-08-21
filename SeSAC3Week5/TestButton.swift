//
//  TestButton.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/21.
//

import UIKit

//커스텀클래스 생성

@IBDesignable //스토리보드 그림으로 보겠다: 런타임에서 확인해야했던 게 컴파일 시점에 볼 수 있다는 장점
class TestButton: UIButton {
    
    @IBInspectable //스토리보드 인스펙터 영역에서 보겠다
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
}
