//
//  DTWave.swift
//  TDWave
//
//  Created by ybk on 16/8/29.
//  Copyright © 2016年 LTD. All rights reserved.
//

import UIKit

class DTWave: UIView {
    
    public var  plotRatio:      CGFloat = 0.6  { didSet{ setup(true) } }
    
    public var valueString:     String?        { didSet{ balanceValue() } }
    
    public var realWaveColor:   UIColor  = UIColor(red:1, green:1, blue:1, alpha:0.35)
    
    public var maskWaveColor:   UIColor  = UIColor(red:1, green:1, blue:1, alpha:0.35)
    
    private var offset:         CGFloat  = 10
    
    private var waveCurvature:  CGFloat  = 3
    
    private var waveSpeed:      CGFloat  = 0.3
    
    private var waveHeight:     CGFloat  = 5
    
    private var timer:CADisplayLink!
    
    var realWaveLayer:CAShapeLayer!
    
    var maskWaveLayer:CAShapeLayer!
    
    var title:CATextLayer?
    
    var value:CATextLayer?

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        realWaveLayer = CAShapeLayer()
        
        layer.addSublayer(realWaveLayer!)
        
        maskWaveLayer = CAShapeLayer()
        
        layer.addSublayer(maskWaveLayer!)
        
        self.layer.cornerRadius = self.frame.size.height / 2
        
        self.layer.masksToBounds = true
        
        title = CATextLayer()
        
        title?.frame = CGRectMake(0, frame.size.height/2 - 40, frame.size.width, 20)
        
        title?.foregroundColor = UIColor.whiteColor().CGColor
        
        title?.alignmentMode = kCAAlignmentCenter
        
        title?.contentsScale = 1;
        
        title?.wrapped = true;
        
        let font:UIFont
        
        font = UIFont.systemFontOfSize(12)
        
        title?.fontSize = font.pointSize;
        
        title?.string = "剩余购买额度"
        
        title?.contentsScale = UIScreen.mainScreen().scale
        
        layer.addSublayer(title!)
        
        
        value = CATextLayer()
        
        value?.frame = CGRectMake(0, frame.size.height/2, frame.size.width, 32)
        
        value?.foregroundColor = UIColor.whiteColor().CGColor
        
        value?.alignmentMode = kCAAlignmentCenter
        
        value?.contentsScale = 1;
        
        value?.wrapped = true;
        
        let valuefont:UIFont
        
        valuefont = UIFont.systemFontOfSize(20)
        
        value?.fontSize = valuefont.pointSize;
    
        value?.contentsScale = UIScreen.mainScreen().scale
        
        layer.addSublayer(value!)
        
    }
    
    func setup(restartTimer:Bool = false)
    {
        
        if restartTimer
        {
            start()
        }
        
        var  Layerframe:CGRect = bounds
        
        Layerframe.origin.y = Layerframe.size.height * (1 - plotRatio) - waveHeight
        
        Layerframe.size.height = waveHeight
        
        realWaveLayer?.frame = Layerframe
        
        realWaveLayer?.fillColor = realWaveColor.CGColor
        
        
        var  maskframe:CGRect = bounds
        
        maskframe.origin.y = maskframe.size.height * (1 - plotRatio) - waveHeight
        
        maskframe.size.height = waveHeight
        
        maskWaveLayer?.frame = maskframe
        
        maskWaveLayer?.fillColor = maskWaveColor.CGColor
        
    }
    
    func balanceValue ()
    {
        [valueString ?? "1,000,000"]
        
        value!.string = valueString
    }
    
    func start()
    {
        timer = CADisplayLink.init(target: self, selector:#selector(self.wave))
        
        timer.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    
    }
    
    func wave(){
        
        offset += waveSpeed
        
        let width = CGRectGetWidth(frame)
        
        let height = waveHeight
        
        let path = CGPathCreateMutable()
        
        var maskY:  Float = 0.0
        
        var Y:   Float = 0.0

        CGPathMoveToPoint(path, nil, 0, height)
        
        let maskpath = CGPathCreateMutable()
        
        CGPathMoveToPoint(maskpath, nil, 0, height)
        
        for x in 1...Int(width) {
            
            Y = Float(height) * sinf(0.01 * Float(waveCurvature) * Float(x) + Float(offset) * 0.045)
            
            CGPathAddLineToPoint(path, nil, CGFloat(x), CGFloat(Y))
            
            maskY = -Y
            
            CGPathAddLineToPoint(maskpath, nil, CGFloat(x), CGFloat(maskY));
        }
        
        CGPathAddLineToPoint(path, nil, CGRectGetWidth(frame), CGRectGetHeight(frame))
        
        CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(frame))
        
        CGPathCloseSubpath(path)
        
        realWaveLayer?.path = path
        
        realWaveLayer?.fillColor = self.realWaveColor.CGColor
        
        CGPathAddLineToPoint(maskpath, nil, CGRectGetWidth(frame), CGRectGetHeight(frame))
        
        CGPathAddLineToPoint(maskpath, nil, 0, CGRectGetHeight(frame))
        
        CGPathCloseSubpath(maskpath)
        
        maskWaveLayer?.path = maskpath
        
        maskWaveLayer?.fillColor = self.maskWaveColor.CGColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   deinit {
        // 执行析构过程
        print("执行析构过程")
    }

}
