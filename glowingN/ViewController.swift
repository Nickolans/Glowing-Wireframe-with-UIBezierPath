//
//  ViewController.swift
//  glowingN
//
//  Created by Nickolans Griffith on 12/23/18.
//  Copyright © 2018 Nickolans Griffith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let layer = CAShapeLayer()
    let shadowLayer = CALayer()
    
    private let backgroundView: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        thisView.backgroundColor = UIColor.clear
        return thisView
    }()
    
    let width: CGFloat = 300
    let height: CGFloat = 500

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .black 
        setupBackgroundView()
        setupLayer()
        beginAnimation()
    }
    
    func setupLayer() {
        
        //Set up normal path
        layer.path = createChristmasTreePath()
        layer.strokeEnd = 0
        layer.lineWidth = 3
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        //Setup shadow path
        shadowLayer.shadowColor = UIColor.green.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowRadius = 15.0
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        
        //insert layer as sublayer of shadowlayer
        shadowLayer.insertSublayer(layer, at: 0)
        //Set shadowlayer as sublayer of backgroundView
        backgroundView.layer.addSublayer(shadowLayer)
    }
    
    func setupBackgroundView() {
        //Add backgroundView to view as subview and set constraints
        self.view.addSubview(backgroundView)
        self.view.addConstraints([
            NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal,
                               toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal,
                               toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundView, attribute: .width, relatedBy: .equal,
                               toItem: nil, attribute: .width, multiplier: 1, constant: width),
            NSLayoutConstraint(item: backgroundView, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .height, multiplier: 1, constant: height)
            ])
    }
    
    func beginAnimation() {
        // Create the animation for the shape view
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 4
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        let color = randomColor()
        
        let coloringAnimation = CABasicAnimation(keyPath: "strokeColor")
        coloringAnimation.toValue = color.cgColor
        coloringAnimation.duration = 1
        coloringAnimation.autoreverses = true
        coloringAnimation.repeatCount = .infinity

        let shadowColoringAnimation = CABasicAnimation(keyPath: "shadowColor")
        shadowColoringAnimation.toValue = color.cgColor
        shadowColoringAnimation.duration = 1
        shadowColoringAnimation.autoreverses = true
        shadowColoringAnimation.repeatCount = .infinity
        
        //Add animation to shape
        layer.add(animation, forKey: "line")
        layer.add(coloringAnimation, forKey: "color")
        shadowLayer.add(shadowColoringAnimation, forKey: "color")
    }
    
    
    func randomColor() -> UIColor {
        let randomNumber = Int.random(in: 1...4)
        var color = UIColor.purple
        switch randomNumber {
        case 1: color = UIColor.purple
        case 2: color = UIColor.blue
        case 3: color = UIColor.yellow
        case 4: color = UIColor.magenta
        default: color = UIColor.purple
        }
        return color
    }
}

//MARK: Paths
extension ViewController{
    
    func createGlowingNPath() -> CGPath {
        
        let path = UIBezierPath()
        
        //Creates starting point and first line
        path.move(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: CGPoint(x: 0.0, y: height / 2))
        
        //First arc
        path.addArc(withCenter: CGPoint(x: width / 4, y: (height / 2)),
                    radius: width / 4,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: true)
        
        //Line connecting the end of the first arc to the next arc
        path.addLine(to: CGPoint(x: width / 2, y: height - (height / 4)))
        
        //Second arc
        path.addArc(withCenter: CGPoint(x: (width * 0.75), y: height - (height / 4)),
                    radius: width / 4,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: false)
        
        //Line connecting second arc to last position
        path.addLine(to: CGPoint(x: width, y: (height / 2) - (width / 4)))
        
        //returns path as cgPath to later set layer.path
        return path.cgPath
    }
    
    func createChristmasTreePath() -> CGPath {
        let path = UIBezierPath()
        
        //Left half of tree
        path.move(to: CGPoint(x: width / 3, y: height))
        path.addLine(to: CGPoint(x: width / 3, y: height - (height * 0.2)))
        path.addLine(to: CGPoint(x: 0.0, y: height - (height * 0.2)))
        path.addLine(to: CGPoint(x: width / 3, y: height - (height * 0.4)))
        path.addLine(to: CGPoint(x: 0.0, y: height - (height * 0.4)))
        path.addLine(to: CGPoint(x: width / 3, y: height - (height * 0.6)))
        path.addLine(to: CGPoint(x: 0.0, y: height - (height * 0.6)))
        path.addLine(to: CGPoint(x: width / 2, y: 0.0))
        
        //Right half of tree
        path.addLine(to: CGPoint(x: width, y: height - (height * 0.6)))
        path.addLine(to: CGPoint(x: width * (2/3), y: height - (height * 0.6)))
        path.addLine(to: CGPoint(x: width, y: height - (height * 0.4)))
        path.addLine(to: CGPoint(x: width * (2/3), y: height - (height * 0.4)))
        path.addLine(to: CGPoint(x: width, y: height - (height * 0.2)))
        path.addLine(to: CGPoint(x: width * (2/3), y: height - (height * 0.2)))
        path.addLine(to: CGPoint(x: width * (2/3), y: height))
        path.close()
        
        return path.cgPath
    }
}

//MARK: - Helpers
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
