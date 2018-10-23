//
//  CanvasViewController.swift
//  Canvas
//
//  Created by user144731 on 10/22/18.
//  Copyright © 2018 rbradley. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    @IBOutlet weak var viewTray: UIView!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat! = nil
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        trayDownOffset = 220
        trayUp = viewTray.center // The initial position of the tray
        trayDown = CGPoint(x: viewTray.center.x ,y: viewTray.center.y + trayDownOffset) // The position of the tray transposed down
       
        
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        
        
        if sender.state == .began {
            trayOriginalCenter = viewTray.center
            
        } else if sender.state == .changed {
            viewTray.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration:0.3, animations: {
                    self.viewTray.center = self.trayDown
                    
                })
            }
            else {
                
                UIView.animate(withDuration:0.3, animations: {
                    self.viewTray.center = self.trayUp
                    
                })
            }
        }
        
    }
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        let location = sender.location(in: view)
        
        
        if sender.state == .began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += viewTray.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed
        {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == .ended
        {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
