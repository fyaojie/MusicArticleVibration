//
//  ViewController.swift
//  MusicArticleVibration
//
//  Created by cool on 2018/5/3.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        view.center = self.view.center
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bgView)
        addAnimation(addVoiceBar(addReplicatorLayer()))
    }
    // 添加复制层
    func addReplicatorLayer() -> CAReplicatorLayer{
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.bgView.bounds
        replicatorLayer.instanceCount = 5 //复制出来5份
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0)
        replicatorLayer.instanceDelay = 0.2 // 设置动画延迟   如果设置0 或者整数速度和高度完全一致，如果设置0.5奇偶数区别跳动
        
        replicatorLayer.instanceColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1).cgColor // 动画颜色
        self.bgView.layer.addSublayer(replicatorLayer)
        return replicatorLayer
    }
    
    // 添加音量震动条
    func addVoiceBar(_ replicatorLayer: CAReplicatorLayer) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 20, height: 100)
        layer.backgroundColor = UIColor.white.cgColor
        layer.position = CGPoint(x: 0, y: self.bgView.bounds.height)
        layer.anchorPoint = CGPoint(x: 0, y: 1) // 设置缩放的锚点
        replicatorLayer.addSublayer(layer)
        return layer;
    }
    
    func addAnimation(_ layer: CALayer) {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale.y"
        animation.toValue = 0
        animation.repeatCount = MAXFLOAT
        animation.duration = 0.5
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
        
    }
}

