//
//  YouTubePlayerView.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoKey: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <html><meta name='viewport' content='width=device-width, initial-scale=1'>
        <style>body,html{margin:0;padding:0;background:#000;height:100%}</style>
        <body>
        <iframe width='100%' height='100%'
          src='https://www.youtube-nocookie.com/embed/\(videoKey)?playsinline=1'
          frameborder='0'
          allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
          allowfullscreen
          referrerpolicy='origin-when-cross-origin'>
        </iframe>
        </body></html>
        """
        let baseURL = URL(string: "https://www.youtube-nocookie.com")!
        webView.loadHTMLString(html, baseURL: baseURL)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(videoKey: videoKey)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let videoKey: String
        init(videoKey: String) { self.videoKey = videoKey }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            fallbackOpen()
        }
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            fallbackOpen()
        }
        
        private func fallbackOpen() {
            if let url = URL(string: "https://www.youtube.com/watch?v=\(videoKey)") {
                UIApplication.shared.open(url)
            }
        }
    }
}
