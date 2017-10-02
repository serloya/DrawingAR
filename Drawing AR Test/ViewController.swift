//
//  ViewController.swift
//  Drawing AR Test
//
//  Created by GammaUser on 9/29/17.
//  Copyright © 2017 sergioloya. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController , ARSCNViewDelegate{
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var shouldDraw = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.showsStatistics = true
        
        sceneView.delegate = self
        
        sceneView.session.run(configuration)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startDrawing(_ sender: Any) {
        shouldDraw = true
    }
    @IBAction func stopDrawing(_ sender: Any) {
        shouldDraw = false
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        print("Rendering")
        
        guard let pointOfView = sceneView.pointOfView else {return}
        
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        
        if(shouldDraw) {
            
            let currentCamaraView = location + orientation
            let node = SCNNode(geometry: SCNSphere(radius: 0.05))
            node.position = currentCamaraView
            
            sceneView.scene.rootNode.addChildNode(node)
            
        }
        
        
        print(orientation.x , orientation.y, orientation.z)
    }


}

func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

