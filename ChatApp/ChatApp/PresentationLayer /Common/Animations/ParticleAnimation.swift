//
//   ParticleAnimation.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 30.11.2021.
//

import UIKit

class ParticleAnimation {
    
    private lazy var tinkoffCell: CAEmitterCell = {
        var tinkoffCell = CAEmitterCell()
        tinkoffCell.contents = UIImage(named: "tinkoffBankLogo.png")?.cgImage
        tinkoffCell.scale = 0.06
        tinkoffCell.scaleRange = 0.2
        tinkoffCell.emissionRange = .pi
        tinkoffCell.lifetime = 5.0
        tinkoffCell.birthRate = 20
        tinkoffCell.velocity = 30
        tinkoffCell.velocityRange = 20
        tinkoffCell.yAcceleration = 30
        tinkoffCell.xAcceleration = 5
        tinkoffCell.spin = -0.5
        tinkoffCell.spinRange = 1.0
        return tinkoffCell
    }()
    
    private lazy var particleEmitter: CAEmitterLayer = {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .point
        emitter.renderMode = .additive
        return emitter
    }()
        
    private func showATinkoffParticleEmitter(view: UIView) {
        particleEmitter.emitterCells = [tinkoffCell]
        view.layer.addSublayer(particleEmitter)
    }

    func touchTracking(sender: UIPanGestureRecognizer, view: UIView) {
        particleEmitter.emitterPosition = sender.location(in: view)
        if sender.state == .ended {
            particleEmitter.lifetime = 0
        } else if sender.state == .began {
            showATinkoffParticleEmitter(view: view)
            particleEmitter.lifetime = 1.0
        }
    }
}
