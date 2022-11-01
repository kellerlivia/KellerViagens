//
//  Validator.swift
//  KellerViagens
//
//  Created by Livia Carvalho Keller on 01/11/22.
//

import UIKit

class Validator: NSObject {
    
    func validaTextFields(_ textFields: [UITextField?]) -> Bool {
        for textField in textFields {
            if textField?.text == "" {
                chacolhar(textField)
                return false
            }
        }
        return true
    }
    
    func chacolhar(_ textField: UITextField?) {
        
        guard let textField = textField else { return }
        let chacolhar = CABasicAnimation(keyPath: "position")
        
        chacolhar.duration = 0.1
        chacolhar.repeatCount = 2
        chacolhar.autoreverses = true
        
        let posicaoInicial = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        chacolhar.fromValue = posicaoInicial
        let posicaoFinal = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        chacolhar.toValue = posicaoFinal
        
        textField.layer.add(chacolhar, forKey: nil)
    }
}
