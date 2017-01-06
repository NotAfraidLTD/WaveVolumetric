//
//  DTWave.swift
//  TDWave
//
//  Created by ybk on 16/8/29.
//  Copyright © 2016年 LTD. All rights reserved.
//

import UIKit

class DTWave: UIView {
    
    public var  plotRatio:      CGFloat = 0.6  { didSet{ setup(restartTimer: true) } }
    
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
        
        title?.frame = CGRect.init( x:0, y:frame.size.height/2 - 40, width:frame.size.width, height:20)
        
        title?.foregroundColor = UIColor.white.cgColor
        
        title?.alignmentMode = kCAAlignmentCenter
        
        title?.contentsScale = 1;
        
        title?.isWrapped = true;
        
        let font:UIFont
        
        font = UIFont.systemFont(ofSize: 12)
        
        title?.fontSize = font.pointSize;
        
        title?.string = "剩余购买额度"
        
        title?.contentsScale = UIScreen.main.scale
        
        layer.addSublayer(title!)
        
        
        value = CATextLayer()
        
        value?.frame = CGRect.init( x:0, y:frame.size.height/2, width:frame.size.width,height:32)
        
        value?.foregroundColor = UIColor.white.cgColor
        
        value?.alignmentMode = kCAAlignmentCenter
        
        value?.contentsScale = 1;
        
        value?.isWrapped = true;
        
        let valuefont:UIFont
        
        valuefont = UIFont.systemFont(ofSize: 20)
        
        value?.fontSize = valuefont.pointSize;
    
        value?.contentsScale = UIScreen.main.scale
        
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
        
        realWaveLayer?.fillColor = realWaveColor.cgColor
        
        
        var  maskframe:CGRect = bounds
        
        maskframe.origin.y = maskframe.size.height * (1 - plotRatio) - waveHeight
        
        maskframe.size.height = waveHeight
        
        maskWaveLayer?.frame = maskframe
        
        maskWaveLayer?.fillColor = maskWaveColor.cgColor
        
    }
    
    func balanceValue ()
    {
        [valueString ?? "1,000,000"]
        
        value!.string = valueString
    }
    
    func start()
    {
        timer = CADisplayLink.init(target: self, selector:#selector(self.wave))
        
        timer.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    
    }
    //定时器触发后,图层发生偏移
    func wave(){
        
        offset += waveSpeed
        
        let width = frame.width
        
        let height = waveHeight
        
        let path = CGMutablePath()
        
        var maskY:  Float = 0.0
        
        var Y:   Float = 0.0
        
        path.move(to: CGPoint.init(x: 0, y: height))
        
        let maskpath = CGMutablePath()
        
        maskpath.move(to: CGPoint.init(x: 0, y: height))

        for x in 1...Int(width) {
            
            Y = Float(height) * sinf(0.01 * Float(waveCurvature) * Float(x) + Float(offset) * 0.045)
            
            path.addLine(to: CGPoint.init(x: CGFloat(x), y: CGFloat(Y)))
            
            maskY = -Y
            
            maskpath.addLine(to: CGPoint.init(x: CGFloat(x), y: CGFloat(maskY)))

        }
        
        path.addLine(to: CGPoint.init(x: frame.width, y: frame.height))
        
        path.addLine(to: CGPoint.init(x: 0, y: frame.height))

        path.closeSubpath()
        
        realWaveLayer?.path = path
        
        realWaveLayer?.fillColor = self.realWaveColor.cgColor
        
        maskpath.addLine(to: CGPoint.init(x:frame.width, y: frame.height))
        
        maskpath.addLine(to: CGPoint.init(x: 0, y: frame.height))
        
        maskpath.closeSubpath()
        
        maskWaveLayer?.path = maskpath
        
        maskWaveLayer?.fillColor = self.maskWaveColor.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   deinit {
        // 执行析构过程
        print("执行析构过程")
    }

}
