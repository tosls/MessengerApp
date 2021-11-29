//
//  Animations.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 28.11.2021.
//

import UIKit

class Animations {
    
    static func buttonShakeAnimation(button: UIButton) {
        
        var buttonAnimations = [CABasicAnimation]()
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(18 * Double.pi / 180)
        rotateAnimation.toValue = CGFloat(-18 * Double.pi / 180)
        buttonAnimations.append(rotateAnimation)
        
        let upDownAnimation = CABasicAnimation(keyPath: "position.y")
        upDownAnimation.fromValue = button.layer.position.y + 5
        upDownAnimation.toValue = button.layer.position.y - 5
        buttonAnimations.append(upDownAnimation)
        
        let leftRightAnimation = CABasicAnimation(keyPath: "position.x")
        leftRightAnimation.fromValue = button.layer.position.x - 5
        leftRightAnimation.toValue = button.layer.position.x + 5
        buttonAnimations.append(leftRightAnimation)

        let groupAnimations = CAAnimationGroup()
        groupAnimations.duration = 0.3
        groupAnimations.autoreverses = true
        groupAnimations.repeatCount = .infinity
        groupAnimations.animations = buttonAnimations
        button.layer.add(groupAnimations, forKey: nil)
    }
}
