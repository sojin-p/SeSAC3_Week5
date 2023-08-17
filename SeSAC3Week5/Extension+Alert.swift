//
//  Extension+Alert.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default) { action in
            
            completionHandler() //이 기능을 밖에서 실행할거야
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(button)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
    }
    
}
