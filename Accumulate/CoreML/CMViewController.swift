//
//  CMViewController.swift
//  Accumulate
//
//  Created by sanjingrihua on 2017/12/28.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

import UIKit
import CoreML
import Vision//视觉封装

class CMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加一个模型
        //加载图片
        let path = Bundle.main.path(forResource: "puppy", ofType: "jpg")
        let imagePath = NSURL.fileURL(withPath: path!)
        //初始化模型
//        let modelFile = Inceptionv3()
//        let model = try! VNCoreMLModel(for: modelFile.model)
//
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
