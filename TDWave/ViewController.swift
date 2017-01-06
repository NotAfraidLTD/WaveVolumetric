//
//  ViewController.swift
//  TDWave
//
//  Created by ybk on 16/8/29.
//  Copyright © 2016年 LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var wave: DTWave?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wave = DTWave.init(frame: CGRect.init(x: 60, y: 200, width: 140, height: 140))
        wave?.backgroundColor = UIColor(red:249.0/255, green:123.0/255, blue:48.0/255, alpha:1)
        wave?.layer.borderWidth = 2
        wave?.layer.borderColor = UIColor.white.cgColor
        wave?.plotRatio = 0.5
        wave?.valueString = "1,100,000.00"
        self.view.addSubview(wave!)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        wave?.removeFromSuperview()
        wave = nil;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

