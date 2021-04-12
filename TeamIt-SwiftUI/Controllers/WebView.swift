/*
 
    This is pretty standard.
    Simple, no javaScripts or anything like that.
    Just simple load WebView
 
 */

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    // var name could be more generic but for this exercise...
    var itunesURL: String
    
    func makeUIView(context: Context) -> some WKWebView {
        
        guard let theURL = URL(string: itunesURL) else {
            return WKWebView()
        }
        
        let webRequest = URLRequest(url: theURL)
        let webView = WKWebView()
        webView.load(webRequest)
        return webView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Need to be here as it's required from the WkWebView protocol
    }
    
    
}

