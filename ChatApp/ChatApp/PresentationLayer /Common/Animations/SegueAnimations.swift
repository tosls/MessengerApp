//
//  SegueAnimations.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 29.11.2021.
//

import UIKit

class ScrollSegue: UIStoryboardSegue {

    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension ScrollSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScrollSegueAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ScrollSegueAnimation()
    }
}

class ScrollSegueAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let slideSpeed = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        slideSpeed
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let contener = transitionContext.containerView
        
        let screenOffUp = CGAffineTransform(translationX: 0, y: -contener.frame.height)
        let screenOffDown = CGAffineTransform(translationX: 0, y: contener.frame.height)
        
        contener.addSubview(fromView)
        contener.addSubview(toView)
        
        toView.transform = screenOffUp
        UIView.animate(withDuration: slideSpeed,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1) {
            fromView.transform = screenOffDown
            fromView.alpha = 0.5
            toView.transform = CGAffineTransform.identity
            toView.alpha = 1
        } completion: { (success) in
            transitionContext.completeTransition(success)
        }
    }
}
