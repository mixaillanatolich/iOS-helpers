//
//  ExtUIImage.swift
//
//  Created by Mikhail Muravev on 11/01/2019.
//  Copyright © 2019 M-Technology. All rights reserved.
//

import UIKit

extension UIImage {
    
    func convertImageToBase64() -> String {
        let imageData = self.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func squareImage(scaledToSize newSize: CGSize) -> UIImage {
        var ratio: CGFloat
        var delta: CGFloat
        var offset: CGPoint
        var sz: CGSize
        
        //make a new square size, that is the resized imaged
        if (self.size.height > self.size.width) {
            sz = CGSize(width: newSize.width, height:newSize.width)
        } else {
            sz = CGSize(width: newSize.height, height:newSize.height)
        }
        
        //figure out if the picture is landscape or portrait, then
        //calculate scale factor and offset
        if (self.size.width > self.size.height) {
            ratio = newSize.width / self.size.width
            delta = (ratio*self.size.width - ratio*self.size.height)
            offset = CGPoint(x:delta/2, y:0)
        } else {
            ratio = newSize.width / self.size.height
            delta = (ratio*self.size.height - ratio*self.size.width)
            offset = CGPoint(x:0, y:delta/2)
        }
        
        //make the final clipping rect based on the calculated values
        let clipRect: CGRect = CGRect(x:-offset.x, y:-offset.y,
                                      width:(ratio * self.size.width) + delta,
                                      height:(ratio * self.size.height) + delta)
        
        UIGraphicsBeginImageContextWithOptions(sz, false, 1.0)
        UIRectClip(clipRect)
        self.draw(in: clipRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
