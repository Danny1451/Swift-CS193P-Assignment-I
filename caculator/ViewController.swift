//
//  ViewController.swift
//  caculator
//
//  Created by 刘旦 on 16/9/26.
//  Copyright © 2016年 dan. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var historyLab: UILabel!
    
    @IBOutlet weak var displayLab: UILabel!
    
    private var userHasInput = false;
    
    private var displayNum: Double {
        get{
            return Double(displayLab.text!)!
        }
        
        set{
            displayLab.text = String(newValue)
        }
    }
    
    @IBAction func digitalClick(_ sender: UIButton) {
        
        if let text = sender.titleLabel?.text{
            
            if userHasInput {
                let currentText = displayLab.text!
                if text == "." && currentText.contains(".") {
                    print("alreay has input .")
                    return;
                }
                displayLab.text = currentText + text
                
                
            }else{
                
                
                displayLab.text = text
                //brain.setCurrentNum(num: displayNum)
            }
            
            userHasInput = true
            
            
        }
        
    }
    
    var brain = CaculatorBrain()
    
    
    @IBAction func operationClick(_ sender: UIButton) {
        
        
        if userHasInput {
            brain.setCurrentNum(num: displayNum)
            userHasInput = false
        }
        
        historyLab.text = brain.history
        
        if let text = sender.titleLabel?.text{
            
            brain.caculate(operation: text)
            
            displayNum = brain.result
            
        }
        historyLab.text = brain.history
    }
}

