//
//  SwiftLog.swift
//  Accumulate
//
//  Created by sanjingrihua on 2018/6/14.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

import UIKit

class SwiftLog: NSObject {
    func printTest(){
        QCLog(message: 123)
    }

    //封装一个方法 打印  全局函数 任何文件都可以调用
    func QCLog<T>(message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line) {
        #if DEBUG
            
            let fileName =  (file as NSString).lastPathComponent
            print("\(fileName)-\(lineNum)-\(message)")//\(funcName)- 有行数了，可以不要方法
            
        #endif
    }
    func printTest1(){
        //获取打印所在的文件
        let file =  (#file as NSString).lastPathComponent
        
        //获取打印所在的方法
        let funcName = #function
        
        //获取打印所在行数
        //        let lineNum = #line
        print("\(file)-123-\(funcName)-\(#line)")
    }
}
