//
//  LocationViewController.swift
//  NefubUIKit
//
//  Created by Jasper Mutsaerts on 03/11/2022.
//

import NefubApi
import UIKit

class LocationViewController: UIViewController {
    var location: Location?
    private var api = NefubApi()


    private var imageView: UIImageView?
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        setImage(UIImage(systemName: "nosign")!)
        
        api.image(locationId: location!.id, completion: self.setImage)
        
    }
    
    private func setImage(_ image: UIImage) {
            
        imageView?.removeFromSuperview()
        
        // Get screen width and height.
        let screenWidth = UIScreen.main.bounds.width
        // let screenHeight = UIScreen.main.bounds.height
            
        // Create a UIImage object use added image file.
        
            
        // Get image height value.
        let iconImageHeight = image.size.height
            
        // Change the image rendering mode to always draw original image. Then it will draw the original image for the button to replace the pure blue rectangle.
        let image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
        // Create a system default type button object.
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
            
        // Set button frame size, the button's width is screen_width - 10, the button's height is image_height - 10.
        imageView.frame = CGRect(x: 10, y: 10, width: screenWidth - 10, height: iconImageHeight + 10)
            

            
        // Set button center point position. The button's center point is screen center point.
        
        imageView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            
        // Add the button to main screen.
        self.view.addSubview(imageView)
        self.imageView = imageView
    }
}
