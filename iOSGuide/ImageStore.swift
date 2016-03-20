//
//  ImageStore.swift
//  iOSGuide
//
//  Created by Howard on 3/18/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache()
    
    // MARK: 
    func imageArchiveURLWith(key: String) -> NSURL {
        let documentsDirectorys = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentURL = documentsDirectorys.first!
        return documentURL.URLByAppendingPathComponent(key)
    }
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
        
        let imageURL = imageArchiveURLWith(key)
        if let imageData = UIImageJPEGRepresentation(image, 0.5) {
            imageData.writeToURL(imageURL, atomically: true)
        }
        
    }
    
    func imageForKey(key: String) -> UIImage? {

        if let exitsImage = cache.objectForKey(key) as? UIImage {
            return exitsImage
        }
        
        let imageURL = imageArchiveURLWith(key)
  
        guard let image = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        
        cache.setObject(image, forKey: key)
        return image
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageURl = imageArchiveURLWith(key)
        do {
            try NSFileManager.defaultManager().removeItemAtURL(imageURl)
        } catch {
            print("Could not remove the image. following this error : \(error)")
        }
    }
}
