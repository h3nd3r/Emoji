//
//  ViewController.swift
//  Smile
//
//  Created by Sara Hender on 11/4/16.
//  Copyright © 2016 Sara Hender. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint! = CGPoint()
    var trayCenterWhenClosed: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var newlyCreatedFace: UIImageView!
    var imageOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenClosed = CGPoint(x: 160, y: 630)
        trayCenterWhenOpen = CGPoint(x: 160, y: 442)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func imagePanGesture(_ sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView

        if sender.state == UIGestureRecognizerState.began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            imageOriginalCenter = imageView.center
            print("original center at: \(imageOriginalCenter)")
            
        } else if sender.state == UIGestureRecognizerState.changed {
            
            let translation = sender.translation(in: self.view)
            newlyCreatedFace.center = CGPoint(x: imageOriginalCenter.x + translation.x + trayView.frame.origin.x,
                                              y: imageOriginalCenter.y + translation.y + trayView.frame.origin.y)
        } else if sender.state == UIGestureRecognizerState.ended {

        }
    }
    
    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        //let point = sender.location(in: self.view)
        
        if sender.state == UIGestureRecognizerState.began {
            trayOriginalCenter = trayView.center
            //print("gesture began at: \(point)")
            //print("original center at: \(trayOriginalCenter)")
        } else if sender.state == UIGestureRecognizerState.changed {
            let translation = sender.translation(in: self.view)
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            //print("gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.ended {
            //print("gesture ended at: \(point)")
            let velocity = sender.velocity(in: self.view)
            if velocity.y > 0 {
                trayView.center = trayCenterWhenClosed
            } else {
                trayView.center = trayCenterWhenOpen
            }
        }
    }
}

