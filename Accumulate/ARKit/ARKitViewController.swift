//
//  ARKitViewController.swift
//  Accumulate
//
//  Created by sanjingrihua on 2018/6/14.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreML
import Vision
//import Inceptionv3
//去官网找模型
//导入头文件
//拿到模型
class ARKitViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    //ARKit
    var latesPrediction : String = "..."
    let bubbleDepth : Float = 0.01 //厚度
    
    //CoreML
    var visionRequests = [VNRequest]()
    let dispatchQueueML = DispatchQueue(label: "vergil")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = (self as! ARSCNViewDelegate)
        
        // Show statistics such as fps and timing information 是否展示细节
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration 创建
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        //创建手势
        let topGesture = UITapGestureRecognizer(target: self, action: #selector(handleTop))
        view.addGestureRecognizer(topGesture)
        
        //coreML
        guard let selectedModel = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("无法识别的模型")
        }
        //设置coreML的识别
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: myRequestMethod)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
        visionRequests = [classificationRequest]
        //循环识别
        
        
        
    }
    func myRequestMethod(request: VNRequest,error: Error?){
        //检查错误
        if (error != nil) {
            print(error?.localizedDescription as Any)
        }
        guard let observartions = request.results else {
            return
        }
        
        //拿结果
        let classifications = observartions[0...1]
            .flatMap({$0 as? VNClassificationObservation})
            .map({"\($0.identifier)\(String(format:"-%.2f",$0.confidence))"})
            .joined(separator:"\n")
        
        //把结果放主线程处理
        DispatchQueue.main.async {
            //打印识别器
            print(classifications)
            //显示可能的结果
            var debugText:String = ""
            debugText += classifications
            print(debugText)
            
            //展示最佳的预测
            var objectName:String = "..."
            objectName = classifications.components(separatedBy: "_")[0]
            objectName = objectName.components(separatedBy: ",")[0]
            print(objectName)
        }
        
    }
    func loopCoreMLUpdate(){
        dispatchQueueML.async {
            //更新结果
            self.updateCoreML()
            //再循环一次
        }
    }
    func updateCoreML(){
        //        coreML 处理图片是直接在GPU里面找图片
        //拿到当前画面的图片
        let pixBuffer:CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)!
        if pixBuffer == nil {
            return
        }
        let ciImg = CIImage(cvImageBuffer: pixBuffer!)
        
        //处理新的结果
        let imageRequestHandler = VNImageRequestHandler(cgImage: ciImg as! CGImage, options: [ : ])
        do {
            try
                imageRequestHandler.perform(self.visionRequests)
        } catch {
            print(error)
        }
        
        
        
    }
    @objc func handleTop(gestureRecognize:UITapGestureRecognizer){
        guard let currentFrame = sceneView.session.currentFrame else {
            return;
        }
        let imagePlan = SCNPlane(width: sceneView.bounds.width/6000, height: sceneView.bounds.height/6000)
        //渲染
        imagePlan.firstMaterial?.diffuse.contents = sceneView.snapshot()
        imagePlan.firstMaterial?.lightingModel = .constant
        //粘贴
        let planNode = SCNNode(geometry: imagePlan)
        sceneView.scene.rootNode.addChildNode(planNode)
        
        //矩阵
        var translate = matrix_identity_float4x4
        translate.columns.3.z = -0.1
        //结果的矩阵 = 当前矩阵 * 变化矩阵
        planNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translate)
        
        
        
    }
    @objc func handleTop1(gestureRecognize:UITapGestureRecognizer){
        //拿到屏幕中心的位置
        let screenCenter:CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        //点击测试 如果点击发生在屏幕上
        let arhitTestResults:[ARHitTestResult] = sceneView.hitTest(screenCenter, types: [.featurePoint])
        //点击作用的范围
        if let closesResult = arhitTestResults.first {
            let transform:matrix_float4x4 = closesResult.worldTransform
            let worldCoord:SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            
            //创建3D文字  在AR 万物皆节点
            let node  = createNewBubbleParentNode(latesPrediction)
            sceneView.scene.rootNode.addChildNode(node)
            node.position = worldCoord
            
        }
        
        
        
        
    }
    func createNewBubbleParentNode(_ text:String) -> SCNNode {
        //设置文字内容
        //设置文字约束
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        //建立文字的格式
        let bubble = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth))
        var font = UIFont(name:"Futura", size: 0.15)//字形 字体
        //        font = font?.withTraits(traits:traitsBold)
        bubble.font = font
        bubble.alignmentMode = kCAGravityCenter
        bubble.firstMaterial?.diffuse.contents = UIColor.orange
        bubble.firstMaterial?.specular.contents = UIColor.white
        bubble.firstMaterial?.isDoubleSided = true
        
        bubble.chamferRadius = CGFloat(bubbleDepth)
        
        //设置文字的节点
        let (minBound,maxBound) = bubble.boundingBox
        let bubbleNode = SCNNode(geometry:bubble)
        //设置文字大小以及位置
        bubbleNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
        //创建小球部分
        let sphere = SCNSphere(radius: 0.005)//5lim
        sphere.firstMaterial?.diffuse.contents = UIColor.cyan
        let sphereNode = SCNNode(geometry: sphere)
        //合并小球 和文字
        let bubbleNodeParent = SCNNode()
        bubbleNodeParent.addChildNode(bubbleNode)
        bubbleNodeParent.addChildNode(sphereNode)
        bubbleNodeParent.constraints = [billboardConstraint]
        
        
        return bubbleNodeParent
        
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
