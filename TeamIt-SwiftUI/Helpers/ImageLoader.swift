/*
 
    This is a class I found and modified.
    There's one thing I don't like, which is the fact that it doesn't cache the iamges
    But I do have the ImageHelper.swift that does cache. I jsut need to make that compatible with SwiftUI
    ...which I'd need some time. :)
 
 */


import SwiftUI

struct RemoteImage: View {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private enum LoadState {
        case loading, success, failure
    }

    
    private class Loader: ObservableObject {
        
        var data = Data()
        var state = LoadState.loading

        init(url: String) {

            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    // Cache the image here...
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image("album-thumbnail"), failure: Image = Image(systemName: "multiply.circle")) {
        
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            // probably here that I'd check if the image is cached and return it
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
