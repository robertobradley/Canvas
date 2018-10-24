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
    
    @IBOutlet weak var happyFace: UIImageView!
    @IBOutlet weak var excitedFace: UIImageView!
    @IBOutlet weak var winkFace: UIImageView!
    @IBOutlet weak var tongueFace: UIImageView!
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var deadFace: UIImageView!
    
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var trayArrow: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //changing colors and adding borders to emojis
        makePretty(image: happyFace)
        makePretty(image: excitedFace)
        makePretty(image: winkFace)
        makePretty(image: tongueFace)
        makePretty(image: sadFace)
        makePretty(image: deadFace)
        
        trayDownOffset = 220
        trayUp = viewTray.center // The initial position of the tray
        trayDown = CGPoint(x: viewTray.center.x ,y: viewTray.center.y + trayDownOffset) // The position of the tray transposed down
       
        
    }
    func makePretty(image: UIImageView)
    {
        let color = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0)
        image.backgroundColor = color
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.layer.borderWidth = 9
        image.layer.borderColor = color.cgColor
    }
    
    @IBAction func onArtsy(_ sender: Any) {
        backGround.image = UIImage(named: "colorful-stripes-watercolor-paint-on-canvas-super-high-resolution-and-quality-background-michal-bednarek")    }
    
    @IBAction func onCanvas(_ sender: Any)
    {
        backGround.image = UIImage(named:"canvas-background-vector-2522867")
    }
    
    @IBAction func onClouds(_ sender: Any)
    {
        backGround.image = UIImage(named:"acrylic-paint-2198458_960_720")
        
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
                    self.trayArrow.image = UIImage(named: "down_arrow")
                    
                })
            }
            else {
                
                UIView.animate(withDuration:0.3, animations: {
                    self.viewTray.center = self.trayUp
                    self.trayArrow.image = UIImage(named: "up_arrow")
                    
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
            makePretty(image: newlyCreatedFace)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += viewTray.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(deletePan(sender: )))
            doubleTapGesture.numberOfTapsRequired = 2
            newlyCreatedFace.addGestureRecognizer(doubleTapGesture)

            
        } else if sender.state == .changed
        {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == .ended
        {
            
        }
    }
    
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
        } else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
    @objc func deletePan(sender: UITapGestureRecognizer)
    {
        newlyCreatedFace = sender.view as! UIImageView
        newlyCreatedFace.removeFromSuperview()
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
