//
//  CaculatorBrain.swift
//  caculator
//
//  Created by 刘旦 on 16/9/26.
//  Copyright © 2016年 dan. All rights reserved.
//

import Foundation


func squere(value : Double,  value2 : Double) -> Double {
    return value + value2
}

class CaculatorBrain {
    
    private var currentNum = 0.0
    
    private var historyStr = ""
    
    let constantdic : Dictionary<String, OperationTypes> = [
        
        "π" : OperationTypes.OperationConstant(M_PI),
        "e" : OperationTypes.OperationConstant(M_E),
        "√" : OperationTypes.OperationBinary(sqrt),
        "+" : OperationTypes.OperationCombinary({ $0 + $1}),
        "-" : OperationTypes.OperationCombinary({ $0 - $1}),
        "×" : OperationTypes.OperationCombinary({ $0 * $1}),
        "÷" : OperationTypes.OperationCombinary({ $0 / $1}),
        "=" : OperationTypes.Equal,
        
    ]
    
    enum OperationTypes {
        case OperationConstant(Double)
        case OperationBinary((Double) -> Double)
        case OperationCombinary( (Double,Double) -> Double)
        case Equal
    }
    func setCurrentNum(num : Double){
        self.currentNum = num
        
        if pendOperation == nil {
            self.historyStr = ""
        }
        appendHostory(extra: String(num))
        
    }
    //增加到历史
    func appendHostory(extra : String){
        if self.historyStr.characters.count == 0 {
            self.historyStr = self.historyStr + extra
        }else{
            self.historyStr = self.historyStr + " " + extra
        }
    }
    
    struct PendOperation {
        
        var binaryFunction : (Double, Double) -> Double
        
        var lastNum : Double
    }
    
    var pendOperation:PendOperation?
    
    
    func caculate(operation :String){
        if let constant = constantdic[operation] {
            switch constant {
            case .OperationConstant(let value): currentNum = value;
            case .OperationBinary(let funcitong) : currentNum = funcitong(currentNum);
            case .OperationCombinary(let function):
                
                appendHostory(extra: operation)
                getResult()
                pendOperation = PendOperation(binaryFunction: function , lastNum : currentNum);
                
            case .Equal :
                getResult()
            }
        }
    }
    
    func getResult(){
        if pendOperation != nil {
            
            currentNum = pendOperation!.binaryFunction(pendOperation!.lastNum, currentNum)
            
            pendOperation = nil;
        }
    }
    
    var result : Double {
        get{
            return currentNum
        }
    }
    
    var history : String {
        get{
            return historyStr
        }
    }
    
    var isPartialResult : Bool{
        get{
            return pendOperation != nil ? true : false
        }
    }
}
