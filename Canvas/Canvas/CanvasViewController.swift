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
    
    var trayOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = viewTray.center
            
        } else if sender.state == .changed {
            viewTray.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
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
