//
//  AnimationControlller.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AnimationController: NSObject {
    
    private let duration: TimeInterval
    private let isPresenting: Bool
    private let originFrame: CGRect
    
    // MARK: - init
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
    }

}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        let container = transitionContext.containerView
        
        // self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        let initialFrame = isPresenting ? originFrame : detailView.frame
        let finalFrame = isPresenting ? detailView.frame : originFrame
        let xScaleFactor = isPresenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = isPresenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                               y: yScaleFactor)
        if isPresenting {
            detailView.transform = scaleTransform
            detailView.center = CGPoint( x: initialFrame.midX, y: initialFrame.midY)
            detailView.clipsToBounds = true
        }
        container.addSubview(toView)
        container.bringSubviewToFront(detailView)
        if isPresenting {
            //update opening animation
            UIView.animate(withDuration: duration, delay:0.0,
                           usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, //gives it some bounce to make the transition look neater than if you have defaults
                animations: {
                    detailView.transform = CGAffineTransform.identity
                    detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            },
                completion:{_ in
                    transitionContext.completeTransition(true)
            }
            )
        } else {
            //update closing animation
            UIView.animate(withDuration: duration, delay:0.0, options: .curveLinear,
                           animations: {
                            detailView.transform = scaleTransform
                            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            },
                           completion:{_ in
                            if !self.isPresenting {
                                // self.dismissCompletion?()
                            }
                            transitionContext.completeTransition(true)
            }
            )
        }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, view: UIView) {
        view.clipsToBounds = true
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
