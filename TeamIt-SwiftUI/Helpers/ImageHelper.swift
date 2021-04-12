import Foundation
import UIKit

/*
 
    Although this was not required, I've decided to use some image Caching for this exercise.
    We can save a little time to display the images if we can cache them.
    Usually works fine for UITableViews when user keeps scrolling up and down.
 
 */


struct ImageHelper {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func loadImageUsingCache(withUrl urlString : String, completion: @escaping (UIImage?) -> Void) {
    
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // check cached image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)  {
            debugPrint("Using Cached Image!")
            completion(cachedImage)
        } else {
            
            // if not, download image from url
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let error = error {
                    debugPrint(error)
                    completion(nil)
                }

                DispatchQueue.main.async {
                    if let data = data,
                       let image = UIImage(data: data) {
                        
                        debugPrint("Using Image from URL")
                        
                        self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(image)
                    }
                }
                
            }).resume()
            
        }
    }
    
}
